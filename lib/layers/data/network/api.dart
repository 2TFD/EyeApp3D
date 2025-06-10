import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/helpers/helpers.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<String> uploadImage(XFile file) async {
    // final upload_id = Helpers().getRandomString(11);
    final token = await UserProvider().getToken();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'https://hysts-shap-e.hf.space/gradio_api/upload?upload_id=qqwwwwwwww',
      ),
    );
    request.files.add(await http.MultipartFile.fromPath('files', file.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return jsonDecode(body)[0];
    } else {
      return 'error';
    }
  }

  Future<String> modelGen(XFile file) async {
    final url = Uri.parse(
      'https://hysts-shap-e.hf.space/gradio_api/call/image-to-3d',
    );
    final pathImage = await uploadImage(file);
    final req = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body:
          '{"data": [{"path":"$pathImage","meta":{"_type":"gradio.FileData"}},0,1,2]}',
    );
    if (req.statusCode == 200) {
      final res = await _getResponse(url, jsonDecode(req.body)['event_id']);
      return res[0]['url'];
    } else {
      return 'error_from_api';
    }
  }

  Future<dynamic> _getResponse(Uri url, String eventId) async {
    Uri uri = Uri.parse('$url/$eventId');
    final res = await http.get(uri);
    return jsonDecode(res.body.split('data:')[1]);
  }

  Future<List<String>> imageGen(String promt) async {
    Uri uri = Uri.parse(
      'https://stabilityai-stable-diffusion.hf.space/call/infer',
    );
    final headers = {'Content-Type': 'application/json'};
    final data = '{"data": ["$promt","$promt",0]}';
    final res = await http.post(uri, headers: headers, body: data);
    final response = await _getResponse(uri, jsonDecode(res.body)['event_id']);
    return [
      response[0][0]['image']['url'],
      response[0][1]['image']['url'],
      response[0][2]['image']['url'],
      response[0][3]['image']['url'],
    ];
  }

  // Future<String> chatGen(String promt) async {
  //   String token = await UserProvider().getToken();
  //   final req = await http.post(
  //     Uri.parse('https://router.huggingface.co/cerebras/v1/chat/completions'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //     body:
  //         '{"messages": [{"role": "user","content": "$promt"}],"model": "qwen-3-32b","stream": false}',
  //   );
  //   final res = req.body;
  //   return jsonDecode(res)['choices'][0]['message']['content'];
  // }

  Future<HttpClientResponse> chatGen(String promt) async {
    String token = await UserProvider().getToken();
    String sessionHash = Helpers().getRandomString(10);
    String baseUrl = 'https://tencent-hunyuan-t1.hf.space';
    await http.post(
      Uri.parse('$baseUrl/gradio_api/queue/join?__theme=system'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body:
          '{"data":[null,[["$promt",null]]],"event_data":null,"fn_index":3,"trigger_id":6,"session_hash":"$sessionHash"}',
    );
    print(sessionHash);

    final client = HttpClient();
    final request = await client.getUrl(
      Uri.parse('$baseUrl/gradio_api/queue/data?session_hash=$sessionHash'),
    );
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    return response;
  }

  Future<String> musicGen(String promt) async {
    String sessionHash = Helpers().getRandomString(10);
    String baseUrl = 'https://facebook-melodyflow.hf.space';
    // String token = await UserProvider().getToken();
    String token = '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';
    print(sessionHash);
    await http.post(
      Uri.parse('$baseUrl/queue/join?__theme=system'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },

      body:
          '{"data":["facebook/melodyflow-t24-30secs","$promt","midpoint",128,0,false,0.2,30,null],"event_data":null,"fn_index":1,"trigger_id":9,"session_hash":"$sessionHash"}',
    );
    final client = HttpClient();
    final request = await client.getUrl(
      Uri.parse('$baseUrl/queue/data?session_hash=$sessionHash'),
    );
    HttpClientResponse response = await request.close();
    final lines = await response.transform(utf8.decoder).join();
    for (var line in lines.trim().split('\n')) {
      if (line.startsWith('data:')) {
        if (jsonDecode(line.substring(5).trim())['msg'] ==
            'process_completed') {
          if (jsonDecode(line.substring(5).trim())['success'] == true) {
            return jsonDecode(
              line.substring(5).trim(),
            )['output']['data'][0]['url'];
          } else {
            return 'error_token';
          }
        }
      }
    }
    return 'null';
  }
}

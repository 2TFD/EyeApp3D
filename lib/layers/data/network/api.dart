import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/helpers/helpers.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Api {
  // todo change with .env
  String url = String.fromEnvironment('BASE_API_URL');
  // String url = 'http://93.183.81.143:8000';

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

  // Future<String> modelGen(XFile file) async {
  //   var uri = Uri.parse('$url/3d');
  //   var request = http.MultipartRequest('POST', uri);
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'file', // имя должно совпадать с параметром FastAPI
  //       file.path,
  //     ),
  //   );
  //   String token = await UserProvider().getToken();
  //   request.headers['accept'] = 'application/json';
  //   request.headers['hf-token'] = token;
  //   request.headers['Content-Type'] = 'multipart/form-data';
  //   final directory = await getApplicationDocumentsDirectory();
  //   String dirToFile;
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     dirToFile = '${directory.path}/${file.name.replaceAll('.jpg', '.glb')}';
  //     final responseBody = await response.stream.bytesToString();
  //     final jsonResponse = json.decode(responseBody);
  //     final datacode = jsonResponse['bytes'] as String;
  //     final decodetBytes = base64.decode(datacode);
  //     (decodetBytes);
  //     final fileModel = File(dirToFile);
  //     await fileModel.create(recursive: true);
  //     await fileModel.writeAsBytes(decodetBytes, flush: true);
  //     return dirToFile;
  //   } else {
  //     print('Ошибка при отправке файла: ${response.statusCode}');
  //     return dirToFile = 'error_from_api';
  //   }
  // }

  Future<dynamic> _getResponse(Uri url, String eventId) async {
    Uri uri = Uri.parse('$url/$eventId');
    final res = await http.get(uri);
    return jsonDecode(res.body.split('data:')[1]);
  }

  // Future<dynamic> _hfRequest(
  //   Map<String, String> headers,
  //   String body,
  //   String token,
  //   String url,
  // ) async {
  //   return await http
  //       .post(Uri.parse(url), headers: headers, body: body)
  //       .then((onValue) {
  //         print('then');
  //         // return onValue.body;
  //       })
  //       .catchError((onError) {
  //         print('onError');
  //         // print(onError);
  //       })
  //       .whenComplete(() {
  //         print('whenComplete');
  //       });
  // }

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

  Future<String> chatGen(String promt) async {
    String token = await UserProvider().getToken();
    final req = await http.post(
      Uri.parse('https://router.huggingface.co/cerebras/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body:
          '{"messages": [{"role": "user","content": "$promt"}],"model": "qwen-3-32b","stream": false}',
    );
    final res = req.body;
    return jsonDecode(res)['choices'][0]['message']['content'];
  }

  Future<String> musicGen(String promt, String style) async {
    var uri = Uri.parse('$url/music');
    var request = http.MultipartRequest('POST', uri);
    String token = await UserProvider().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['promt'] = promt;
    request.headers['token'] = token;
    request.headers['style'] = style;
    final directory = await getApplicationDocumentsDirectory();

    String dirToFile;
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      String base64code = jsonResponse['0'];
      final decodetBytes = base64.decode(base64code);
      String filename = Helpers().getRandomString(25);
      dirToFile = '${directory.path}/$filename.wav';
      final fileMusic = File(dirToFile);
      await fileMusic.create(recursive: true);
      await fileMusic.writeAsBytes(decodetBytes, flush: true);
      return fileMusic.path;
    } else {
      return dirToFile = 'error_from_api';
    }
  }
}

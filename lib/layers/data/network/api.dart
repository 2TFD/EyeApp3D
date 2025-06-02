import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/helpers.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Api {
  String url = 'http://93.183.81.143:8000';

  Future<String> modelGen(XFile file) async {
    var uri = Uri.parse('$url/3d');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // имя должно совпадать с параметром FastAPI
        file.path,
      ),
    );
    String token = await UserProvider().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['hf-token'] = token;
    request.headers['Content-Type'] = 'multipart/form-data';
    final directory = await getApplicationDocumentsDirectory();
    String dirToFile;
    var response = await request.send();
    if (response.statusCode == 200) {
      dirToFile = '${directory.path}/${file.name.replaceAll('.jpg', '.glb')}';
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      final datacode = jsonResponse['bytes'] as String;
      final decodetBytes = base64.decode(datacode);
      (decodetBytes);
      final fileModel = File(dirToFile);
      await fileModel.create(recursive: true);
      await fileModel.writeAsBytes(decodetBytes, flush: true);
      return dirToFile;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return dirToFile = 'error_from_api';
    }
  }

  Future<dynamic> _getResponse(Uri url, String eventId) async {
    Uri uri = Uri.parse('$url/$eventId');
    final res = await http.get(uri);
    print('${jsonDecode(res.body.split('data:')[1])}');
    return jsonDecode(res.body.split('data:')[1]);
  }

  // Future<String> modelGen(XFile file) async {
  //   Uri uri = Uri.parse(
  //     'https://hysts-shap-e.hf.space/gradio_api/call/image-to-3d',
  //   );
  //   print(file.path);
  //   final headers = {'Content-Type': 'application/json'};
  //   final base64File = 'qwe';
  //   // final base64File = base64Encode(await file.readAsBytes());
  //   // final qwe = html.Blob(await file.readAsBytes());
  //   final data =
  //       '{"data": [{"path":"$file","meta":{"_type":"gradio.FileData"}},0,1,2]}';
  //   final res = await http.post(uri, headers: headers, body: data);
  //   print(jsonDecode(res.body)['event_id']);
  //   // final response = await _getResponse(uri, jsonDecode(res.body)['event_id']);
  //   // print(response);
  //   return res.body;
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


  // Future<Stream<String>> chatGen(String promt, bool isThinking) async {
  //   String token = await UserProvider().getToken();
  //   final headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //   };
  //   final data =
  //       '{"messages": [{"role": "user","content": "$promt"}],"model": "qwen-3-32b","stream": false}';
  //   final url = Uri.parse(
  //     'https://router.huggingface.co/cerebras/v1/chat/completions',
  //   );
  //   final res = await http.post(url, headers: headers, body: data);
  //   final status = res.statusCode;
  //   if (status != 200) throw Exception('http.post error: statusCode= $status');
    
  //   final response = jsonDecode(res.body);
  //   List<String> listResponse = response['choices'][0]['message']['content']
  //       .split('</think>');
  //   // return isThinking
  //   //     ? '${listResponse[0]} <think end>\n ${listResponse[1]}'
  //   //     : listResponse[1];
  //   return Stream.empty();
  // } 


  /// 0.1 get chat gen
  Future<dynamic> _chatGet(Map<dynamic, dynamic> body) async {
    return await http.post(Uri.parse(
    '{{baseurl}}/cerebras/v1/chat/completions',
      
    ), headers: {
      'Authorization': 'Bearer ',
      'Content-Type': 'application/json',
    }, body: {
      ...body
    }).then((onValue) {
      return onValue;
    }).catchError((onError) {

    }).whenComplete(() {

    });
  }

  Future<String> chatGen(String promt, bool isThinking) async {
    String token = await UserProvider().getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final data =
        '{"messages": [{"role": "user","content": "$promt"}],"model": "qwen-3-32b","stream": false}';
    final url = Uri.parse(
      'https://router.huggingface.co/cerebras/v1/chat/completions',
    );
    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) {
      final response = jsonDecode(res.body);
    List<String> listResponse = response['choices'][0]['message']['content']
        .split('</think>');
    return isThinking
        ? '${listResponse[0]} <think end>\n ${listResponse[1]}'
        : listResponse[1];
    }else{
      return 'error: $status';
    }
  }


  Future<String> musicGen(String promt, String style) async {
    var uri = Uri.parse('$url/music');
    var request = http.MultipartRequest('POST', uri);
    // String token = await Storage().getToken();
    String token = await UserProvider().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['promt'] = promt;
    request.headers['token'] = token;
    request.headers['style'] = '$style';
    final directory = await getApplicationDocumentsDirectory();

    String dirToFile;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Файл успешно отправлен');
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      String base64code = jsonResponse['0'];
      final decodetBytes = base64.decode(base64code);
      String filename = Helpers().getRandomString(25);
      dirToFile = '${directory.path}/$filename.wav';
      final fileMusic = File(dirToFile);
      await fileMusic.create(recursive: true);
      await fileMusic.writeAsBytes(decodetBytes, flush: true);
      // Storage().addToListMusic([promt, style, fileMusic.path]);
      return fileMusic.path;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return dirToFile = 'error_from_api';
    }
  }
}

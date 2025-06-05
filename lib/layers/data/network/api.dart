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

  // Future<String> modelGen(XFile imageFile) async {
  //   // Считываем файл и кодируем в Base64
  //   final token = await UserProvider().getToken();
  //   final bytes = await imageFile.readAsBytes();
  //   final base64Img = base64Encode(bytes);
  //   // Параметры генерации
  //   final seed = 0;
  //   final guidance = 3.0;
  //   final steps = 64;
  //   // Формируем JSON для запроса (используем image-to-3d)
  //   // final apiUrl = 'https://hysts-shap-e.hf.space/';
  //   final apiUrl = 'https://hysts-shap-e.hf.space/gradio_api/call/image-to-3d';
  //   // final apiUrl = 'https://hysts-shap-e.hf.space/api/predict/image-to-3d';
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token', // если API требует токен
  //   };
  //   final body = jsonEncode({
  //     'data': ['data:image/png;base64,$base64Img', seed, guidance, steps],
  //   });
  //   // Отправляем POST-запрос
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: headers,
  //     body: body,
  //   );
  //   if (response.statusCode == 200) {
  //     final respJson = jsonDecode(response.body);
  //     // Берём путь к файлу .glb на сервере
  //     print(respJson);
  //     final String glbPath = respJson['data'][0]['name'];
  //     // Скачиваем сам .glb по полученному пути
  //     final fileUrl = 'https://hysts-shap-e.hf.space/file=$glbPath';
  //     final glbResp = await http.get(Uri.parse(fileUrl));
  //     if (glbResp.statusCode == 200) {
  //       // Сохраняем GLB в локальный файл (например, в папку приложения)
  //       // Здесь просто пример: сохраняем в переменную или файл через path_provider и File.
  //       final bytes = glbResp.bodyBytes;
  //       // TODO: написать в файл или передать bytes в виджет отображения
  //       // Например: await File('model.glb').writeAsBytes(bytes);
  //       print('GLB-модель получена, размер: ${bytes.length} байт');
  //     }
  //     return '';
  //   } else {
  //     print('Ошибка запроса: ${response.statusCode}');
  //     return '';
  //   }
  // }

  Future<bool> uploadImage(XFile file) async {
    // final uploadId = 'qweqweqweewq';
    // final url = Uri.parse(
    //   'https://hysts-shap-e.hf.space/gradio_api/upload?upload_id=$uploadId',
    // );
    final url = Uri.parse(
      'https://hysts-shap-e.hf.space/gradio_api/queue/join',
    );
    final base64dfile = base64Encode(await file.readAsBytes());

    final request =
        http.MultipartRequest('POST', url)
          ..fields['file_base64'] = base64dfile
          ..fields['file_name'] = file.name;
    final response = await request.send();
    print(response.stream.bytesToString());
    if (response.statusCode == 200) {
      print('Файл успешно загружен!');
    } else {
      print('Ошибка загрузки: ${response.statusCode}');
      print('Ответ сервера: ${await response.stream.bytesToString()}');
    }
    return true;
  }

  Future<String> modelGen(XFile file) async {
    // final base64dfile = base64Encode(await file.readAsBytes());
    // final token = await UserProvider().getToken();
    // final uuid = '67448ba4-88dc-4426-a01c-5ed95d638a7a';
    // final url = Uri.parse(
    //   'https://hysts-shap-e.hf.space/gradio_api/queue/join',
    // );
    // final req = await http.post(
    //   url,
    //   // headers: {
    //   //   // 'Authorization': 'Bearer $token',
    //   //   'Content-Type': 'application/json',
    //   // },
    //   body:
    //       '{"data": ["data:image/png:$base64dfile, 0, 1, 2],"session_hash": $uuid}',
    // );
    // print('/////////////////////////${req.body}');
    // // final response = await _getResponse(url, jsonDecode(req.body)['event_id']);
    await uploadImage(file);
    return 'error_from_api';
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
    print('${jsonDecode(res.body.split('data:')[1])}');
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
      return fileMusic.path;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return dirToFile = 'error_from_api';
    }
  }
}

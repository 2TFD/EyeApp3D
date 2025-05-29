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
    // String token = await Storage().getToken();
    String token = await UserProvider().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['hf-token'] = token;
    request.headers['Content-Type'] = 'multipart/form-data';

    // int fordelInt = file.name.length - 4; // for del '.jpg'
    final directory = await getApplicationDocumentsDirectory();

    String dirToFile;

    // Отправляем запрос
    var response = await request.send();
    // Читаем ответ
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

  Future<List<String>> imageGen(String promt) async {
    var uri = Uri.parse('$url/image');
    var request = http.MultipartRequest('POST', uri);
    String token = await UserProvider().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['promt'] = promt;
    request.headers['token'] = token;
    final directory = await getApplicationDocumentsDirectory();
    String dirToFile;

    // Отправляем запрос
    var response = await request.send();
    // Читаем ответ
    if (response.statusCode == 200) {
      print('Файл успешно отправлен');
      List<String> pathsFiles = [];
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      for (int i = 0; i < 4; i++) {
        final base64code = jsonResponse[i.toString()];
        final decodetBytes = base64.decode(base64code);
        (decodetBytes);
        String filename = Helpers().getRandomString(25);
        dirToFile = '${directory.path}/$filename${i.toString()}.jpg';
        final fileImage = File(dirToFile);

        await fileImage.create(recursive: true);
        await fileImage.writeAsBytes(decodetBytes, flush: true);
        pathsFiles.add(fileImage.path);
      }
      // Storage().addToListImage(pathsFiles);
      return pathsFiles;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return [];
    }
  }

  Future<String> chatGen(String promt) async {
    var uri = Uri.parse('$url/chat');
    var request = http.MultipartRequest('POST', uri);
    // String token = await Storage().getToken();
    String token = await UserProvider().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['promt'] = promt;
    request.headers['token'] = token;
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Файл успешно отправлен');
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      String res = jsonResponse['0'];
      return res;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return response.statusCode.toString();
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

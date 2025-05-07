import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/helpers.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
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
        file.path, // путь к твоему файлу
      ),
    );
    String token = await Storage().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['hf-token'] = token;
    request.headers['Content-Type'] = 'multipart/form-data';

    int fordelInt = file.name.length - 4; // for del '.jpg'
    final directory = await getApplicationDocumentsDirectory();

    String dirToFile;

    // Отправляем запрос
    var response = await request.send();
    // Читаем ответ
    if (response.statusCode == 200) {
      print('Файл успешно отправлен');

      dirToFile = '${directory.path}/${file.name.substring(0, fordelInt)}.glb';

      final responseBody = await response.stream.bytesToString();
      print(responseBody.length);

      final jsonResponse = json.decode(responseBody); // convert to json
      final datacode = jsonResponse['bytes'] as String;
      debugPrint(datacode);
      final decodetBytes = base64.decode(datacode);
      (decodetBytes);

      final fileModel = File(dirToFile);

      await fileModel.create(recursive: true);
      print('создание файла');
      await fileModel.writeAsBytes(decodetBytes, flush: true);
      print('создание файла закончено');
      print(await fileModel.exists());
      print(await fileModel.length());
      print(dirToFile);
      return dirToFile;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return dirToFile = 'error_from_api';
    }
  }

  Future<List<String>> imageGen(String promt) async {
    var uri = Uri.parse('$url/image');
    var request = http.MultipartRequest('POST', uri);
    String token = await Storage().getToken();
    request.headers['accept'] = 'application/json';
    request.headers['promt'] = promt;
    request.headers['token'] = token;
    print(token);
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
        dirToFile = '${directory.path}/$filename${i.toString()}.jpg'; ////////////
        final fileImage = File(dirToFile);

        await fileImage.create(recursive: true);
        print('создание файла');
        await fileImage.writeAsBytes(decodetBytes, flush: true);
        print('создание файла закончено');
        print(await fileImage.exists());
        print(await fileImage.length());
        print(dirToFile);
        pathsFiles.add(fileImage.path);
      }
      print(pathsFiles);
      Storage().addToListImage(pathsFiles);
      print(await Storage().getListImage());
      return pathsFiles;
    } else {
      print('Ошибка при отправке файла: ${response.statusCode}');
      return [];
    }
  }
}

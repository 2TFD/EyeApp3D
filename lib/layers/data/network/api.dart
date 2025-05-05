import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Api {
  Future<String> addPhoto(XFile file) async {
    var uri = Uri.parse('http://185.11.135.213:8000/add');
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
}

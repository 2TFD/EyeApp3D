import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ImagesRepository {
  final _pref = SharedPreferences.getInstance();

  Future<String> createFile(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = await http.get(Uri.parse(url));
    final file = File('${directory.path}/${url.split('/').last}');
    await file.writeAsBytes(image.bodyBytes);
    print(file.path);
    return file.path;
  }

  Future<Images> newImages(String promt) async {
    List<String>? listImages = await Api().imageGen(promt);
    Images image = Images(
      promt: promt,
      imagePathOne: await createFile(listImages[0]),
      imagePathTwo: await createFile(listImages[1]),
      imagePathThree: await createFile(listImages[2]),
      imagePathFour: await createFile(listImages[3]),
    );
    saveImages(image);
    return image;
  }

  Future<void> saveImages(Images images) async {
    final pref = await _pref;
    List<String>? models = await pref.getStringList('images');
    if (models != null) {
      models.add(jsonEncode(images.toMap()));
      pref.setStringList('images', models);
    } else {
      models = [];
      models.add(jsonEncode(images.toMap()));
      pref.setStringList('images', models);
    }
  }

  Future<List<Images>> getListImages() async {
    final pref = await _pref;
    List<String>? images = await pref.getStringList('images');
    return images!.map((e) {
      return Images.fromMap(jsonDecode(e));
    }).toList();
  }

  Future<void> delListModels() async {
    final pref = await _pref;
    pref.setStringList('images', []);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ModelRepository {
  final _pref = SharedPreferences.getInstance();

  Future<String> createFile(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final model = await http.get(Uri.parse(url));
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(model.bodyBytes);
    print(file.path);
    return file.path;
  }

  Future<Model> newModel(XFile image) async {
    final modelLink = await Api().modelGen(image);
    final modelPath = await createFile(
      modelLink,
      image.name.replaceAll('.jpg', '.glb'),
    );
    Model model = Model(modelPath: modelPath, imagePath: image.path);
    saveModel(model);
    return model;
  }

  Future<void> saveModel(Model model) async {
    final pref = await _pref;
    List<String>? models = await pref.getStringList('models');
    if (models != null) {
      models.add(jsonEncode(model.toMap()));
      pref.setStringList('models', models);
    } else {
      models = [];
      models.add(jsonEncode(model.toMap()));
      pref.setStringList('models', models);
    }
  }

  Future<List<Model>> getListModels() async {
    final pref = await _pref;
    List<String>? models = await pref.getStringList('models');
    return models!.map((e) {
      return Model.fromMap(jsonDecode(e));
    }).toList();
  }

  Future<void> delListModels() async {
    final pref = await _pref;
    pref.setStringList('models', []);
  }
}

import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ModelRepository {
  final _pref = SharedPreferences.getInstance();

  Future<Model> newModel(XFile image) async {
    final modelPath = await Api().modelGen(image);
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

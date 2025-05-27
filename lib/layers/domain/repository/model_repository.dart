import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ModelRepository {
  final _pref = SharedPreferences.getInstance();

  Future<Model> newModel(XFile image) async {
  final model = await Api().modelGen(image); 
    return Model(modelPath: model, imagePath: image.path);
  }

  Future<void> saveModel(Model model)async{
    final pref = await _pref;
    List<String>? models = await pref.getStringList('models');
    if(models != null){
      models.add(jsonEncode(model.toMap()));
      pref.setStringList('models', models); 
    }else{
      models = [];
      models.add(jsonEncode(model.toMap()));
      pref.setStringList('models', models); 
    }
  }

  Future<List<Model>> getListModels()async{
    final pref = await _pref;
    List<String>? models = await pref.getStringList('models');
    return models!.map((e){
      return  Model.fromMap(jsonDecode(e));
    }).toList(); 
  }

  Future<void> delListModels()async{
    final pref = await _pref;
    pref.setStringList('models', []);
  }
} 
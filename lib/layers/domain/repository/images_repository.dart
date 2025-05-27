import 'dart:convert';

import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ImagesRepository {
  final _pref = SharedPreferences.getInstance();

  Future<Images> newImages(String promt) async {
  List<String>? listImages = await Api().imageGen(promt); 
    return Images(
      promt: promt, 
      imagePathOne: listImages[0], 
      imagePathTwo: listImages[1], 
      imagePathThree: listImages[2], 
      imagePathFour: listImages[3]);
  }

  Future<void> saveImages(Images images)async{
    final pref = await _pref;
    List<String>? models = await pref.getStringList('images');
    if(models != null){
      models.add(jsonEncode(images.toMap()));
      pref.setStringList('images', models); 
    }else{
      models = [];
      models.add(jsonEncode(images.toMap()));
      pref.setStringList('images', models); 
    }
  }

  Future<List<Images>> getListImages()async{
    final pref = await _pref;
    List<String>? images = await pref.getStringList('images');
    return images!.map((e){
      return  Images.fromMap(jsonDecode(e));
    }).toList(); 
  }

  Future<void> delListModels()async{
    final pref = await _pref;
    pref.setStringList('images', []);
  }
}
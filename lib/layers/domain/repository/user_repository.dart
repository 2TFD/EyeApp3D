import 'dart:convert';

import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  final _pref = SharedPreferences.getInstance();

  Future<void> updateUser( user) async {
    final pref = await _pref;
    await pref.setString('user', user.toJson());
  }

  Future<void> delUser() async {
    final pref = await _pref;
    await pref.setString('user', '');
  }

  Future<UserEntity> readUser() async {
    final pref = await _pref;
    String? user = await pref.getString('user');
    UserEntity userEntity = UserEntity.fromJson(user!);
    return userEntity;
  }
}

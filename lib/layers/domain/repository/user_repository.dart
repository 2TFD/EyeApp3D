import 'dart:convert';

import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  final _pref = SharedPreferences.getInstance();

  Future<void> updateUser(User user) async {
    final pref = await _pref;
    await pref.setString('user', jsonEncode(user.toMap()));
  }

  Future<User> readUser() async {
    final pref = await _pref;
    String? user = await pref.getString('user');
    if (user != null) {
      return User.fromMap(jsonDecode(user));
    } else {
      return User(token: 'token', tokens: 1000, name: 'name', isInit: false);
    }
  }
}

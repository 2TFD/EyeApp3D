import 'dart:convert';

import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final _storage = SharedPreferences.getInstance();

  void initStorage() async {
    final storage = await _storage;
    await storage.setString('name', '');
    await storage.setString('token', '');
    await storage.setStringList('listPathPhoto', []);
    await storage.setBool('isInit', true);
    await storage.setStringList('listPathImage', []);
    await storage.setBool('themeDark', true);
    await storage.setStringList('messages', []);
    await storage.setInt('tokens', 1000);
    await storage.setStringList('listPathMusic', []);
  }

  Future<User> getUser() async {
    String token = await getToken();
    int tokens = await getTokens();
    String name = await getName();
    return User(token: token, tokens: tokens, name: name);
  }

  void setZeroTokens() async {
    final storage = await _storage;
    await storage.setInt('tokens', 0);
  }

  void addTokens(int num) async {
    final storage = await _storage;
    int? currentTokens = await storage.getInt('tokens');
    if (currentTokens != null) {
      int newtokens = currentTokens + num;
      await storage.setInt('tokens', newtokens);
    } else {
      int newtokens = currentTokens! + num;
      await storage.setInt('tokens', newtokens);
    }
  }

  void buyForTokens(int price) async {
    final storage = await _storage;
    int? currentTokens = await storage.getInt('tokens');
    if (currentTokens != null) {
      int newtokens = currentTokens - price;
      await storage.setInt('tokens', newtokens);
    } else {
      int newtokens = currentTokens! - price;
      await storage.setInt('tokens', newtokens);
    }
  }

  Future<int> getTokens() async {
    final storage = await _storage;
    int? tokens = storage.getInt('tokens');
    if (tokens != null) {
      return tokens;
    } else {
      return 0;
    }
  }

  void changeTheme() async {
    final storage = await _storage;
    bool? themeDark = await storage.getBool('themeDark');
    await storage.setBool('themeDark', !themeDark!);
  }

  Future<bool> getThemeDark() async {
    final storage = await _storage;
    final res = await storage.getBool('themeDark');
    return res!;
  }

  Future<bool> getIsInit() async {
    final storage = await _storage;
    bool? res = await storage.getBool('isInit');
    if (res == null) {
      return false;
    } else {
      return res;
    }
  }

  void setAll(String name, String token) async {
    final storage = await _storage;
    await storage.setString('name', name);
    await storage.setString('token', token);
  }

  void setToken(String newToken) async {
    final storage = await _storage;
    await storage.setString('token', newToken);
  }

  Future<String> getToken() async {
    final storage = await _storage;
    String? token = await storage.getString('token');
    return token!;
  }

  Future<String> getName() async {
    final storage = await _storage;
    String? name = await storage.getString('name');
    return name!;
  }

  void addToListPhoto(String element) async {
    final storage = await _storage;
    List<String>? nowList = await storage.getStringList('listPathPhoto');
    nowList!.add(element);
    List<String> newList = nowList;
    await storage.setStringList('listPathPhoto', newList);
    print(await storage.getStringList('listPathPhoto'));
  }

  Future<List<String>> getListPhoto() async {
    final storage = await _storage;
    List<String>? list = await storage.getStringList('listPathPhoto');
    return list!;
  }

  void clearListPhoto() async {
    final storage = await _storage;
    await storage.setStringList('listPathPhoto', []);
  }

  void addToListImage(List<String> list) async {
    final storage = await _storage;
    String stringList = list.join(';');
    List<String>? nowList = await storage.getStringList('listPathImage');
    nowList!.add(stringList);
    List<String> newList = nowList;
    await storage.setStringList('listPathImage', newList);
    print(await storage.getStringList('listPathImage'));
  }

  Future<List<List<String>>> getListImage() async {
    final storage = await _storage;
    List<String>? list = await storage.getStringList('listPathImage');
    List<List<String>> listString =
        list!.map((e) {
          return e.split(';');
        }).toList();
    return listString;
  }

  void addToListMusic(List<String> inputList) async {
    final storage = await _storage;
    List<String>? nowList = await storage.getStringList('listPathMusic');
    if (nowList != null) {
      int count = nowList.length;
      inputList.add(count.toString());
      String stringList = inputList.join(';');
      nowList.add(stringList);
      List<String> newList = nowList;
      await storage.setStringList('listPathMusic', newList);
    } else {
      nowList = [];
      int count = nowList.length;
      inputList.add(count.toString());
      String stringList = inputList.join(';');
      nowList.add(stringList);
      List<String> newList = nowList;
      await storage.setStringList('listPathMusic', newList);
    }
  }

  Future<List<List<String>>> getListMusic() async {
    final storage = await _storage;
    List<String>? list = await storage.getStringList('listPathMusic');
    List<List<String>> listString =
        list!.map((e) {
          return e.split(';');
        }).toList();
    return listString;
  }

  void clearListImage() async {
    final storage = await _storage;
    await storage.setStringList('listPathImage', []);
  }

  void clearListMessages() async {
    final storage = await _storage;
    storage.setStringList('messages', []);
  }

  void addToListMessages(Map<String, dynamic> dataMap) async {
    final storage = await _storage;
    List<String>? list = storage.getStringList('messages');
    final jsonData = jsonEncode(dataMap);
    if (list != null) {
      list.add(jsonData);
      await storage.setStringList('messages', list);
    } else {
      await storage.setStringList('messages', []);
      list!.add(jsonData);
      await storage.setStringList('messages', list);
    }
  }

  Future<List<dynamic>> getListMessages() async {
    final storage = await _storage;
    List<String>? list = storage.getStringList('messages');
    if (list != null) {
      return list.map((e) {
        return jsonDecode(e);
      }).toList();
    } else {
      return [];
    }
  }

  void changeLastMessage(Map<String, dynamic> dataMap) async {
    final storage = await _storage;
    List<String>? list = storage.getStringList('messages');
    final jsonData = jsonEncode(dataMap);
    if (list != null) {
      list.insert(list.length, jsonData);
      await storage.setStringList('messages', list);
    } else {
      await storage.setStringList('messages', []);
      list!.insert(list.length, jsonData);
      await storage.setStringList('messages', list);
    }
  }
}

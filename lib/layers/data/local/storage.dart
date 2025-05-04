import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final _storage = SharedPreferences.getInstance();

  void addAll(String name, String token, bool isReg) async {
    final storage = await _storage;
    await storage.setString('name', name);
    await storage.setString('token', token);
    await storage.setBool('isReg', isReg);
  }

  void chandeToken(String newToken) async {
    final storage = await _storage;
    await storage.setString('token', newToken);
  }

  Future<String> readToken() async {
    final storage = await _storage;
    String? token = await storage.getString('token');
    return token!;
  }

  Future<String> readName() async {
    final storage = await _storage;
    String? name = await storage.getString('name');
    return name!;
  }

  Future<bool> readisReg() async {
    final storage = await _storage;
    bool? isReg = await storage.getBool('isReg');
    if (isReg != null) {
      return isReg;
    } else {
      return false;
    }
  }

  void addToList(String element) async {
    final storage = await _storage;
    if (await storage.getStringList('list') != null) {
      List<String>? nowList = await storage.getStringList('list');
      nowList!.add(element);
      List<String> newList = nowList;
      await storage.setStringList('list', newList);
      print(await storage.getStringList('list'));
    } else {
      await storage.setStringList('list', []);
    }
  }

  Future<List<String>> readList() async {
    final storage = await _storage;
    List<String>? list = await storage.getStringList('list');
    return list!;
  }

  void delList() async {
    final storage = await _storage;
    await storage.setStringList('list', []);
  }
}

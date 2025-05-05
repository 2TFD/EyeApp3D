import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final _storage = SharedPreferences.getInstance();

  void initStorage() async {
    final storage = await _storage;
    await storage.setString('name', '');
    await storage.setString('token', '');
    await storage.setStringList('list', []);
    await storage.setBool('isInit', true);
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

  void addToList(String element) async {
    final storage = await _storage;
    List<String>? nowList = await storage.getStringList('list');
    nowList!.add(element);
    List<String> newList = nowList;
    await storage.setStringList('list', newList);
    print(await storage.getStringList('list'));
  }

  Future<List<String>> getList() async {
    final storage = await _storage;
    List<String>? list = await storage.getStringList('list');
    return list!;
  }

  void clearList() async {
    final storage = await _storage;
    await storage.setStringList('list', []);
  }
}

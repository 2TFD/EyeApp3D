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

  void clearListImage() async {
    final storage = await _storage;
    await storage.setStringList('listPathImage', []);
  }
}

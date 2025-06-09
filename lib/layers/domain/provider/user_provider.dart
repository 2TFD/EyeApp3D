import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:eyeapp3d/layers/domain/repository/user_repository.dart';

class UserProvider extends UserRepository {
  Future<void> setToken(String token) async {
    User user = await readUser();
    await updateUser(
      User(
        token: token,
        tokens: user.tokens,
        name: user.name,
        isInit: user.isInit,
      ),
    );
  }

  Future<void> setIsInit(bool isInit) async {
    User user = await readUser();
    await updateUser(
      User(
        token: user.token,
        tokens: user.tokens,
        name: user.name,
        isInit: isInit,
      ),
    );
  }

  Future<bool> getIsInit() async {
    User user = await readUser();
    if (user.isInit == true) {
      return user.isInit;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    User user = await readUser();
    return user.token;
  }

  Future<int> getTokens() async {
    User user = await readUser();
    return user.tokens;
  }

  Future<void> addTokens(int num) async {
    User user = await readUser();
    await updateUser(
      User(
        token: user.token,
        tokens: user.tokens + num,
        name: user.name,
        isInit: user.isInit,
      ),
    );
  }

  Future<void> buyTokens(int price) async {
    User user = await readUser();
    await updateUser(
      User(
        token: user.token,
        tokens: user.tokens - price,
        name: user.name,
        isInit: user.isInit,
      ),
    );
  }
}

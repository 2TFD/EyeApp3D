import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:eyeapp3d/layers/domain/repository/user_repository.dart';

class UserProvider extends UserRepository {
  
  Future<void> setToken(String token)async{
    User user = await readUser();
    await updateUser(User(token: token, tokens: user.tokens, name: user.name));
  }
  Future<String> getToken(String token)async{
    User user = await readUser();
    return user.token;
  }
  
  Future<void> addTokens(int num)async{
    User user = await readUser();
    await updateUser(User(token: user.token, tokens: user.tokens+num, name: user.name));
  }

  Future<void> buyTokens(int price)async{
    User user = await readUser();
    await updateUser(User(token: user.token, tokens: user.tokens-price, name: user.name));
  }
  
}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';

part 'test_state.dart';

class TestCubit extends Cubit<User> {
  TestCubit() : super(User(token: '', tokens: 0, name: '', isInit: true));

  void getUser() async {
    // User user = await Storage().getUser();
    User user = await UserProvider().readUser();
    emit(user);
  }

  // void setToken(String token) async {
  //   Storage().setToken(token);

  //   getUser();
  // }

  void addTokens(int num) async {
    UserProvider().addTokens(num);
    getUser();
  }

  void buyForTokens(int price) async {
    UserProvider().buyTokens(price);
    getUser();
  }
}

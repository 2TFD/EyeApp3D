import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/domain/entity/user_entity.dart';

part 'test_state.dart';

class TestCubit extends Cubit<UserEntity> {
  TestCubit() : super(UserEntity(token: '', tokens: 0, name: ''));

  void getUser() async {
    UserEntity user = await Storage().getUser();
    emit(user);
  }

  void setToken(String token) async {
    Storage().setToken(token);
    getUser();
  }

  void addTokens(int num) async {
    Storage().addTokens(num);
    getUser();
  }

  void buyForTokens(int price) async {
    Storage().buyForTokens(price);
    getUser();
  }
}

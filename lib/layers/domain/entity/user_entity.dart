import 'package:equatable/equatable.dart';

class UserEntity {
  UserEntity({required this.token, required this.tokens, required this.name});
  String token;
  int tokens;
  String name;

}

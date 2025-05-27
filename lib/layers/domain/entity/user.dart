import 'dart:convert';

class User  {
  String token;
  int tokens;
  String name;
  User({
    required this.token,
    required this.tokens,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'tokens': tokens,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      tokens: map['tokens'] as int,
      name: map['name'] as String,
    );
  }
}

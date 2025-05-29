class User {
  String token;
  int tokens;
  String name;
  bool isInit;
  User({required this.token, required this.tokens, required this.name, required this.isInit});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'token': token, 'tokens': tokens, 'name': name, 'isInit': isInit};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] as String,
      tokens: map['tokens'] as int,
      name: map['name'] as String,
      isInit: map['isInit'] as bool,
    );
  }
}

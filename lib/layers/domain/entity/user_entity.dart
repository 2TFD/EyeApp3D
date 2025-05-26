import 'dart:convert';

class UserEntity  {
  String token;
  int tokens;
  String name;
  UserEntity({
    required this.token,
    required this.tokens,
    required this.name,
  });

  UserEntity copyWith({
    String? token,
    int? tokens,
    String? name,
  }) {
    return UserEntity(
      token: token ?? this.token,
      tokens: tokens ?? this.tokens,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'tokens': tokens,
      'name': name,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      token: map['token'] as String,
      tokens: map['tokens'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserEntity(token: $token, tokens: $tokens, name: $name)';

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.tokens == tokens &&
      other.name == name;
  }

  @override
  int get hashCode => token.hashCode ^ tokens.hashCode ^ name.hashCode;
}

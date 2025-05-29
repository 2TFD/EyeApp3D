class Message {
  Message({required this.message, required this.time, required this.user});
  String message;
  DateTime time;
  bool user;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'message': message, 'time': time.toString(), 'user': user};
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] as String,
      time: DateTime.parse(map['time']), 
      user: map['user'] as bool,
    );
  }
}

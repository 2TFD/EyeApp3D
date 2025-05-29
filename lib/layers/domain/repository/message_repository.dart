import 'dart:convert';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MessageRepository {
  final _pref = SharedPreferences.getInstance();

  Future<Message> newMessage(String promt) async {
    String? message = await Api().chatGen(promt);
    DateTime time = DateTime.now();
    Message mes = Message(message: message, time: time, user: false);
    saveMessage(mes);
    return mes;
  }

  Future<void> saveMessage(Message message) async {
    final pref = await _pref;
    List<String>? messages = pref.getStringList('messages');
    messages!.add(jsonEncode(message.toMap()));
    pref.setStringList('messages', messages);
  }

  Future<List<Message>> getListMessages() async {
    final pref = await _pref;
    List<String>? messages = await pref.getStringList('messages');
    if (messages != null) {
      return messages.map((e) {
        return Message.fromMap(jsonDecode(e));
      }).toList();
    } else {
      pref.setStringList('messages', []);
      return [];
    }
  }

  Future<void> delListMessages() async {
    final pref = await _pref;
    pref.setStringList('messages', []);
  }
}

import 'dart:convert';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MessageRepository {
  final _pref = SharedPreferences.getInstance();

  Future<bool> getThinking() async {
    final pref = await _pref;
    final res = await pref.getBool('thinking');
    return res ?? false;
  }

  Future<void> changeThinking() async {
    bool isThinking = await getThinking();
    final pref = await _pref;
    await pref.setBool('thinking', !isThinking);
  }

  Stream<Message> newMessage(String promt, bool isThinling) async* {
    String message = '';
    final stream = await Api().chatGen(promt);
    await for (var e in stream) {
      if (e.startsWith('data:')) {
        try {
          final jsonStr = e.substring(6).trim();
          if (jsonStr.isNotEmpty) {
            final jsonData = jsonDecode(jsonStr);
            // print(jsonData["msg"] == 'process_generating');
            if (jsonData["msg"] == 'process_generating') {
              message = message + jsonData["output"]['data'][0][0][2];
              // print(message);
              yield Message(
                message: message,
                time: DateTime.now(),
                user: false,
              );
            }
            if (jsonData["msg"] == 'close_stream') {
              saveMessage(
                Message(message: message, time: DateTime.now(), user: false),
              );
            }
          }
        } catch (error) {
          print('error: $error');
        }
      }
    }
    // stream.listen((e) {
    //   if (e.startsWith('data:')) {
    //     try {
    //       final jsonStr = e.substring(6).trim();
    //       if (jsonStr.isNotEmpty) {
    //         final jsonData = jsonDecode(jsonStr);
    //         if (jsonData["msg"] == 'process_generating') {
    //           message = message + jsonData["output"]['data'][0][0][2];
    //           print(message);

    //         }
    //       }
    //     } catch (error) {
    //       print('error: $error');
    //     }
    //   }
    // });

    // String message = await Api().chatGen(promt);
    // String response = jsonDecode(message)['choices'][0]['message']['content'];
    // List<String> listmessage = message.split('</think>');
    // DateTime time = DateTime.now();
    // Message mes = Message(
    //   message:
    // isThinling
    //     ? '${listmessage[0]}<end think>${listmessage[1]}'
    //     : listmessage[1],
    // time: time,
    // user: false,
    // );
    // saveMessage(mes);
    // return mes;
    // return Message(message: 'message', time: DateTime.now(), user: false);
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

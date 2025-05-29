import 'package:eyeapp3d/core/brand/price_list.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/message.dart';
import 'package:eyeapp3d/layers/domain/provider/message_provider.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  List<Widget> messages = [];
  final textFiledcontroll = TextEditingController();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void updateChat() async {
    // List<dynamic> list = await Storage().getListMessages();
    List<Message> list = await MessageProvider().getListMessages();
    widget.messages =
        list.map((e) {
          bool user = e.user;
          return Align(
            alignment: user ? Alignment.centerRight : Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Text(e.message, style: TextStyle(color: Colors.white)),
            ),
          );
        }).toList();
    setState(() {});
  }

  @override
  void initState() {
    updateChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('chat'),
              Spacer(),
              IconButton(
                onPressed: () async {
                  // Storage().clearListMessages();
                  MessageProvider().delListMessages();
                  updateChat();
                },
                icon: Icon(Icons.clear_rounded),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(children: widget.messages),
                      ),
                    ),
                    TextField(
                      controller: widget.textFiledcontroll,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            // int tokens = await Storage().getTokens();
                            int tokens = await UserProvider().getTokens();
                            if (tokens >= PriceList().chat_gen) {
                              // Storage().buyForTokens(PriceList().chat_gen);
                              UserProvider().buyTokens(PriceList().chat_gen);
                              String message = widget.textFiledcontroll.text;
                              widget.textFiledcontroll.text = '';
                              MessageProvider().saveMessage(
                                Message(
                                  message: message,
                                  time: DateTime.now(),
                                  user: true,
                                ),
                              );
                              updateChat();
                              // Storage().addToListMessages({
                              //   'user': false,
                              //   'message': await Api().chatGen(
                              //     message.replaceAll('\n', ' '),
                              //   ),
                              // });
                              MessageProvider().newMessage(
                                message.replaceAll('\n', ' '),
                              );
                              updateChat();
                            } else {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => SimpleDialog(
                                      backgroundColor: Colors.transparent,
                                      title: Center(child: Text('no tokes(')),
                                    ),
                              );
                            }
                          },
                          icon: Icon(Icons.send_sharp),
                        ),
                        hintText: 'enter promt',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 25),
                      ),
                      minLines: null,
                      maxLines: null,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

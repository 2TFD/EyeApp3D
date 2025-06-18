import 'dart:async';

import 'package:eyeapp3d/core/brand/price_list.dart';
import 'package:eyeapp3d/layers/domain/entity/message.dart';
import 'package:eyeapp3d/layers/domain/provider/message_provider.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  final textFiledcontroll = TextEditingController();
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isThinking = false;
  List<Widget> messages = [];
  String lastWord = '';
  bool loading = false;
  StreamSubscription<Message>? stream;
  void changeThinking() async {
    isThinking = !isThinking;
    await MessageProvider().changeThinking();
  }

  Future<void> updateChat() async {
    List<Message> list = await MessageProvider().getListMessages();
    messages =
        list.map((e) {
          bool user = e.user;
          return Align(
            alignment: user ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    '${e.time.hour}:${e.time.minute}',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  Text(e.message, style: TextStyle(color: Colors.white)),
                ],
              ),
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
  void dispose() {
    if (stream != null) {
      stream!.cancel();
      MessageProvider().saveMessage(
        Message(
          message: '$lastWord (stopped)',
          time: DateTime.now(),
          user: false,
        ),
      );
    }
    super.dispose();
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
              PopupMenuButton(
                color: Colors.black,
                surfaceTintColor: Colors.white,
                onOpened: () async {
                  isThinking = await MessageProvider().getThinking();
                },
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        enabled: false,
                        child: Row(
                          children: [
                            Text(
                              'show thinking',
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            StatefulBuilder(
                              builder:
                                  (context, setState) => Switch(
                                    value: isThinking,
                                    activeColor: Colors.white,
                                    onChanged: (bool value) async {
                                      setState(() {
                                        changeThinking();
                                      });
                                      this.setState(() {});
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        enabled: false,
                        child: Row(
                          children: [
                            Text(
                              'clean chat',
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () async {
                                await MessageProvider().delListMessages();
                                updateChat();
                              },
                              icon: Icon(Icons.clear_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        child: Column(children: messages),
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
                        suffixIcon:
                            loading
                                // ? CupertinoActivityIndicator()
                                ? IconButton(
                                  onPressed: () {
                                    stream!.cancel();
                                    MessageProvider().saveMessage(
                                      Message(
                                        message: '$lastWord (stopped)',
                                        time: DateTime.now(),
                                        user: false,
                                      ),
                                    );
                                    setState(() {
                                      loading = !loading;
                                    });
                                  },
                                  icon: Icon(Icons.stop),
                                )
                                : IconButton(
                                  onPressed: () async {
                                    int tokens =
                                        await UserProvider().getTokens();
                                    if (tokens >= PriceList().chat_gen) {
                                      UserProvider().buyTokens(
                                        PriceList().chat_gen,
                                      );
                                      String message =
                                          widget.textFiledcontroll.text;
                                      widget.textFiledcontroll.text = '';
                                      setState(() {});
                                      MessageProvider().saveMessage(
                                        Message(
                                          message: message,
                                          time: DateTime.now(),
                                          user: true,
                                        ),
                                      );
                                      updateChat();
                                      stream = MessageProvider()
                                          .newMessage(
                                            message.replaceAll('\n', ' '),
                                            isThinking,
                                          )
                                          .listen(
                                            (e) {
                                              loading = true;
                                              if (lastWord == '') {
                                                messages.add(
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(''),
                                                  ),
                                                );
                                              }
                                              lastWord = e.message;
                                              messages.last = Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${e.time.hour}:${e.time.minute}',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        e.message,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );

                                              setState(() {});
                                            },
                                            onDone:
                                                () => setState(() {
                                                  loading = false;
                                                }),
                                          );
                                      loading = false;
                                      updateChat();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => SimpleDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              title: Center(
                                                child: Text('no tokes('),
                                              ),
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

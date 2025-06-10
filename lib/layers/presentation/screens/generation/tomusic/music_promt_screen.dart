import 'package:eyeapp3d/core/brand/price_list.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MusicPromtScreen extends StatelessWidget {
  MusicPromtScreen({super.key});

  final inputcontroller = TextEditingController();

  final List<String> styleList = [
    'pop',
    'rock',
    'hip hop',
    'electronic',
    'jazz',
    'classical',
    'ambient',
    'folk',
    'metal',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: inputcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 50),
              CupertinoButton(
                color: Colors.white,
                child: Text('to gen!', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  int tokens = await UserProvider().getTokens();
                  if (tokens >= PriceList().image_gen) {
                    UserProvider().buyTokens(PriceList().music_gen);
                    context.push(
                      '/gen/music_promt/music_view',
                      extra: <String, dynamic>{
                        'promt': inputcontroller.text,
                        'filePath': 'null',
                        'indexTrack': 'null',
                      },
                    );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:eyeapp3d/core/brand/brand_theme.dart';
import 'package:eyeapp3d/core/brand/price_list.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MusicPromtScreen extends StatelessWidget {
  MusicPromtScreen({super.key});

  final inputcontroller = TextEditingController();

  List<String> styleList = [
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
              Container(
                height: 200,
                width: 300,
                child: Expanded(
                  child: ListWheelScrollView(
                    physics: FixedExtentScrollPhysics(),
                    itemExtent: 100,
                    perspective: 0.005,
                    children:
                        styleList.map((e) {
                          return GestureDetector(
                            onTap: () async {
                              int tokens = await Storage().getTokens();
                              if (tokens >= PriceList().music_gen) {
                                Storage().buyForTokens(PriceList().music_gen);
                                context.push(
                                '/gen/music_promt/music_view',
                                extra: <String, dynamic>{
                                  'promt': inputcontroller.text,
                                  'style': e,
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
                            child: Container(
                              width: 200,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '$e generate ->',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

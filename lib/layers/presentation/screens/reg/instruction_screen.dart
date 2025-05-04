import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class InstructionScreen extends StatelessWidget {
  InstructionScreen({super.key});

  List<Widget> instructionWidgers = [
    Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('создайте или войдите \nв аккаунт huggingface')
        ],
      )
    ),
    Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('в настройках откройте \n"access tokens" \nсоздайте новый токен')
        ],
      )
    ),
    Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('сохраните токен \nпереходите дальше ')
        ],
      )
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 400.0),
            items: instructionWidgers,
          ),
          SizedBox(height: 50),
          CupertinoButton(
            child: Text(
              'перейти на сайт',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => context.push('/reg/howto/web'),
          ),
          SizedBox(height: 50),
          CupertinoButton(
            child: Text('далее', style: TextStyle(color: Colors.white)),
            onPressed: () =>  context.push('/reg/howto/save'),
          ),
        ],
      ),
    );
  }
}

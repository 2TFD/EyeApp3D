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
          Text('create or sign in \nto a huggingface account', style: TextStyle(color: Colors.black))
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
          Text('in settings open \n"access tokens" \ncreate a new token', style: TextStyle(color: Colors.black))
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
          Text('save token \nproceed further', style: TextStyle(color: Colors.black),)
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
              'go to site',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onPressed: () => context.push('/reg/howto/web'),
          ),
          SizedBox(height: 50),
          CupertinoButton(
            child: Text('Next', style: Theme.of(context).textTheme.bodyMedium),
            onPressed: () =>  context.push('/reg/howto/save'),
          ),
        ],
      ),
    );
  }
}

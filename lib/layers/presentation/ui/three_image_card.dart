import 'dart:io';

import 'package:flutter/material.dart';
class ThreeImageCard extends StatelessWidget {
  ThreeImageCard({super.key, required this.list});
  List<String> list;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.file(File(list[0])),
        height: 200,
        width: 200,
        color: Colors.white,
    );
  }
}

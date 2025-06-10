import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/domain/entity/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.model});

  final Model model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Image.file(File(model.imagePath)),
      ),
      onTap: () {
        // Directory dir = await getApplicationDocumentsDirectory();
        // context.pushNamed(
        //   'view3d',
        //   extra: {'par1': XFile(model.modelPath), 'par2': dir.path},
        // );
        context.push(
          '/gen/camera/preview/view3d',
          extra: <String, dynamic>{
            'fileImage': XFile(model.imagePath),
            // 'dirPath': dir.path,
            'dirPath': model.modelPath,
          },
        );
      },
    );
  }
}

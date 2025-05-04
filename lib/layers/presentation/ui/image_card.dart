import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class ImageCard extends StatelessWidget {
  ImageCard({super.key, required this.fileImage});

  File fileImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 250,
        width: 250,
        color: Colors.black,
        child: Image.file(fileImage),
      ),
      onTap: () async {
        Directory dir = await getApplicationDocumentsDirectory();
        context.pushNamed(
          'view3d',
          extra: {'par1': XFile(fileImage.path), 'par2': dir.path},
        );
      },
    );
  }
}

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class PreviewScreen extends StatefulWidget {
  PreviewScreen({super.key, required this.image});

  XFile image;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('preview')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Image.file(File(widget.image.path))),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => context.go('/camera'),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Directory dir = await getApplicationDocumentsDirectory();
                    context.goNamed(
                      'view3d',
                      extra: {'par1': widget.image, 'par2': dir.path},
                    );
                  },
                  icon: Icon(Icons.check),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

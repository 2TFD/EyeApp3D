import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/brand/brand_theme.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:eyeapp3d/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;

  XFile? image;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            print(e.code);
          }
        });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('you photo')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CameraPreview(cameraController),
              SizedBox(height: 30),
              IconButton(onPressed:  () async {
                  image = await cameraController.takePicture();
                  print(image!.path);
                  Storage().addToListPhoto(image!.path);
                  print(await Storage().getListPhoto());
                  context.goNamed('preview', extra: {'par1': image!});
                }, icon: Icon(Icons.circle_rounded, size: 80,)),
            ],
          ),
        ),
      ),
    );
  }
}

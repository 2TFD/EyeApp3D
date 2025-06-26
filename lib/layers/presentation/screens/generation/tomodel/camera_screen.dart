import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? cameraController;
  List<CameraDescription> cameras = [];

  XFile? image;

  @override
  void initState() {
    super.initState();
    Permission.camera.request().then((_) async {
      try {
        cameras = await availableCameras();
      } on CameraException catch (e) {
        debugPrint('error camera $e');
      }
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
        enableAudio: false,
      );
      cameraController!
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
    });
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('you photo')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CameraPreview(cameraController!),
              SizedBox(height: 30),
              IconButton(
                onPressed: () async {
                  image = await cameraController!.takePicture();
                  context.go('/gen/camera/preview', extra: image!);
                },
                icon: Icon(Icons.circle_rounded, size: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

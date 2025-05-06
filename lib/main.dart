import 'dart:async';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/brand/brand_theme.dart';
import 'package:eyeapp3d/core/routing.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Permission.camera.request();
  try {
    cameras = await availableCameras();
    print(cameras);
  } on CameraException catch (e) {
    print('error camera $e');
  }
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BrandTheme().darkTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: Routing().router,
    );
  }
}

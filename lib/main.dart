import 'dart:async';
import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/brand/brand_theme.dart';
import 'package:eyeapp3d/core/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
  );
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('error camera $e');
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


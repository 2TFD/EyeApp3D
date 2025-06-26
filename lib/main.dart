import 'dart:async';
import 'package:eyeapp3d/core/brand/brand_theme.dart';
import 'package:eyeapp3d/core/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: BrandTheme().darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: Routing().router,
    );
  }
}


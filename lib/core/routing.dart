import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/presentation/screens/camera_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/gallery_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/home_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/preview_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/instruction_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/save_data_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/web_page_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/routing_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/settings_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/view_images_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/view_model_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/welcome_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class Routing {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      bool isInit = await Storage().getIsInit();
      if (!isInit) {
        Storage().initStorage();
        return '/reg';
      } else {
        return null;
      }
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                RoutingScreen(statefulNavigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => HomeScreen(),
                routes: [
                  GoRoute(
                    path: '/settings',
                    builder: (context, state) => SettingsScreen(),
                  ),


                  GoRoute(
                    path: '/test',
                    builder: (context, state) => ViewImagesScreen(promt: 'cars'),
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/camera',
                builder: (context, state) => CameraScreen(),
                routes: [
                  GoRoute(
                    path: 'preview',
                    name: 'preview',
                    builder: (context, state) {
                      // PreviewScreen(image: state.extra as XFile),
                      Map<String, dynamic> extra =
                          state.extra as Map<String, dynamic>;
                      return PreviewScreen(image: extra['par1']);
                    },
                    routes: [
                      // GoRoute(
                      //   name: 'view3d',
                      //   path: 'view3d',
                      //   builder:
                      //       (context, state) => ViewModelScreen(
                      //         fileImage: state.extra as XFile,
                      //       ),
                      GoRoute(
                        path: 'view3d',
                        name: 'view3d',
                        builder: (context, state) {
                          Map<String, dynamic> extra =
                              state.extra as Map<String, dynamic>;
                          return ViewModelScreen(
                            fileImage: extra['par1'],
                            dirPath: extra['par2'],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gallery',
                builder: (context, state) => GalleryScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/reg',
        builder: (context, state) => WelcomeScreen(),
        routes: [
          GoRoute(
            path: 'howto',
            builder: (context, state) => InstructionScreen(),
            routes: [
              GoRoute(
                path: 'web',
                builder: (context, state) => WebPageScreen(),
              ),
              GoRoute(
                path: 'save',
                builder: (context, state) => SaveDataScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}



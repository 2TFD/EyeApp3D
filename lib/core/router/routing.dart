import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:eyeapp3d/layers/presentation/screens/gallery/gallery_music_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/tomodel/camera_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/chat/chat_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/gallery/gallery_images_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/gallery/gallery_models_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/gallery/gallery_root_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/gen_root_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/toimage/get_promt_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/tomusic/music_promt_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/tomusic/view_music_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/home_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/tomodel/preview_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/instruction_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/save_data_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/web_page_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/routing_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/settings_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/toimage/view_images_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/generation/tomodel/view_model_screen.dart';
import 'package:eyeapp3d/layers/presentation/screens/reg/welcome_screen.dart';
import 'package:go_router/go_router.dart';

class Routing {
  GoRouter get router => GoRouter(
    // initialLocation: '/gen/music_promt',
    initialLocation: '/',
    redirect: (context, state) async {
      // bool isInit = await Storage().getIsInit();
      bool isInit = await UserProvider().getIsInit();
      if (!isInit) {
        // Storage().initStorage();
        await UserProvider().setIsInit(true);
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
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/gen',
                builder: (context, state) => GenRootScreen(),
                routes: [
                  GoRoute(
                    path: 'camera',
                    builder: (context, state) => CameraScreen(),
                    routes: [
                      GoRoute(
                        path: 'preview',
                        // name: 'preview',
                        // builder: (context, state) {
                        //   Map<String, dynamic> extra =
                        //       state.extra as Map<String, dynamic>;
                        //   return PreviewScreen(image: extra['par1']);
                        // },
                        builder:
                            (context, state) => PreviewScreen(
                              image:
                                  // (state.extra
                                  //     as Map<String, dynamic>)['image'] as XFile,
                                  state.extra as XFile
                            ),
                        routes: [
                          GoRoute(
                            path: 'view3d',
                            // name: 'view3d',
                            builder:
                                (context, state) => ViewModelScreen(
                                  fileImage:
                                      (state.extra
                                          as Map<String, dynamic>)['fileImage'] as XFile,
                                  dirPath:
                                      (state.extra
                                          as Map<String, dynamic>)['dirPath'] as String,
                                ),
                            // {
                            // Map<String, dynamic> extra =
                            //     state.extra as Map<String, dynamic>;
                            // return ViewModelScreen(
                            //   fileImage: extra['par1'],
                            //   dirPath: extra['par2'],
                            // ),
                            // },
                          ),
                        ],
                      ),
                    ],
                  ),

                  GoRoute(
                    path: '/getpromt',
                    builder: (context, state) => GetPromtScreen(),
                    routes: [
                      GoRoute(
                        path: 'viewimage',
                        builder:
                            (context, state) =>
                                ViewImagesScreen(promt: state.extra as String),
                      ),
                    ],
                  ),

                  GoRoute(
                    path: 'chat',
                    builder: (context, state) => ChatScreen(),
                  ),
                  GoRoute(
                    path: 'music_promt',
                    builder: (context, state) => MusicPromtScreen(),
                    routes: [
                      GoRoute(
                        path: 'music_view',
                        builder:
                            (context, state) => ViewMusicScreen(
                              promt:
                                  (state.extra as Map<String, dynamic>)['promt']
                                      as String,
                              filePath:
                                  (state.extra
                                      as Map<String, dynamic>)['filePath'],
                              indexTrack:
                                  (state.extra
                                      as Map<String, dynamic>)['indexTrack'],
                            ),
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
                builder: (context, state) => GalleryRootScreen(),
                routes: [
                  GoRoute(
                    path: 'gallerymodels',
                    builder: (context, state) => GalleryModelsScreen(),
                  ),
                  GoRoute(
                    path: 'galleryimages',
                    builder: (context, state) => GalleryImagesScreen(),
                  ),
                  GoRoute(
                    path: 'gallerymusic',
                    builder: (context, state) => GalleryMusicScreen(),
                  ),
                ],
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

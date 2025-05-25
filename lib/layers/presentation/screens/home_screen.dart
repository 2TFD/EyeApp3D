import 'dart:math';

import 'package:eyeapp3d/core/helpers.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/cubit/test_cubit.dart';
import 'package:eyeapp3d/layers/domain/entity/user_entity.dart';
import 'package:eyeapp3d/layers/presentation/ui/cards/image_card.dart';
import 'package:eyeapp3d/layers/presentation/ui/diologs/set_folder_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = TestCubit();
  List<int> tokensForCase = [0];
  int currnetWin = 0;
  void setRandomList() {
    List<int> list = [0];
    for (int i = 0; i <= 100; i++) {
      Random random = new Random();
      int num = random.nextInt(300);
      list.add(num);
    }
    tokensForCase = list;
    print(tokensForCase);
  }

  @override
  void initState() {
    final subscription = cubit.stream.listen((e) {
      setState(() {});
    });
    cubit.getUser();
    super.initState();
  }

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.push('/settings'),
          icon: Icon(Icons.settings),
        ),
        title: Text('home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cubit.state.name, style: TextStyle(fontSize: 30)), // name
            Text('tokens:${cubit.state.tokens}'), // tokens
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => SimpleDialog(
                        title: Center(child: Text(cubit.state.token)), // token
                        backgroundColor: Colors.transparent,
                      ),
                );
              },
              child: Text('show token', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            Center(
              child: CupertinoButton(
                color: Colors.white,
                child: Text(
                  'GET TOKENS',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: [
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'здесь могла \nбыть \nваша реклама)',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            CupertinoButton(
                              color: Colors.white,
                              child: Text(
                                'GET TOKENS',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                // cubit.addTokens(100);
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => SimpleDialog(
                                        backgroundColor: Colors.white,
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            width: 300,
                                            child: Expanded(
                                              child: PageView.builder(
                                                itemCount: 10000000,
                                                controller: pageController,
                                                onPageChanged: (value) {
                                                  currnetWin = value;
                                                },
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (context, index) => Center(
                                                      child: Container(
                                                        width: 100,
                                                        height: 50,
                                                        color: Colors.black,
                                                        child: Center(
                                                          child: Text(
                                                            tokensForCase[index]
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          CupertinoButton(
                                            color: Colors.white,
                                            child: Text(
                                              'RUN',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () async {
                                              pageController.jumpTo(0);
                                              setRandomList();
                                              pageController
                                                  .animateToPage(
                                                    100,
                                                    duration: Duration(
                                                      seconds: 3,
                                                    ),
                                                    curve: Curves.easeOutCubic,
                                                  )
                                                  .then((e) {
                                                    cubit.addTokens(tokensForCase[currnetWin]);
                                                  });
                                              
                                            },
                                          ),
                                        ],
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// wheel
// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';




// class HomeScreen extends StatefulWidget {
//   @override
//   _WheelOfFortuneState createState() => _WheelOfFortuneState();
// }

// class _WheelOfFortuneState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   double _currentAngle = 0;
//   int numSections = 8;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 5),
//     );
//   }

//   void _spinWheel() {
//     final random = Random();
//     final spins = 5 + random.nextInt(5); // от 5 до 9 оборотов
//     final targetAngle = 2 * pi * spins + (random.nextDouble() * 2 * pi);

//     _animation = Tween<double>(
//       begin: _currentAngle,
//       end: _currentAngle + targetAngle,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate))
//       ..addListener(() {
//         setState(() {
//           _currentAngle = _animation.value;
//         });
//       });

//     _controller.forward(from: 0).whenComplete(() {
//       final resultAngle = _currentAngle % (2 * pi);
//       final selected = numSections - 1 - (resultAngle / (2 * pi / numSections)).floor();
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text("Сектор: $selected"),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomPaint(
//           painter: WheelPainter(numSections: numSections, angle: _currentAngle),
//           size: Size(300, 300),
//         ),
//         ElevatedButton(
//           onPressed: _spinWheel,
//           child: Text("Крутить"),
//         )
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class WheelPainter extends CustomPainter {
//   final int numSections;
//   final double angle; // текущий угол поворота

//   WheelPainter({required this.numSections, required this.angle});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..style = PaintingStyle.fill;
//     final radius = size.width / 2;
//     final center = Offset(radius, radius);

//     for (int i = 0; i < numSections; i++) {
//       final sweepAngle = 2 * pi / numSections;
//       final startAngle = i * sweepAngle + angle;
//       paint.color = i.isEven ? Colors.orange : Colors.green;
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         startAngle,
//         sweepAngle,
//         true,
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant WheelPainter oldDelegate) =>
//       oldDelegate.angle != angle;
// }

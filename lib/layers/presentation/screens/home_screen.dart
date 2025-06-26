import 'dart:math';
import 'package:eyeapp3d/core/deprecated/cubit/test_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = TestCubit();
  bool light = true;
  List<int> tokensForCase = [0];
  int currnetWin =0;
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
    cubit.stream.listen((e) {
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
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => SimpleDialog(
                                        backgroundColor: Colors.white,
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            width: 300,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: PageView.builder(
                                                    itemCount: 101,
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
                                              ],
                                            ),
                                          ),
                                          CupertinoButton(
                                            color: Colors.white,
                                            child: Text(
                                              'GET RANDOM TOKENS',
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
                                                    cubit.addTokens(
                                                      tokensForCase[currnetWin],
                                                    );
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

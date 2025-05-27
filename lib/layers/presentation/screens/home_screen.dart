import 'dart:math';

import 'package:eyeapp3d/core/helpers.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/cubit/test_cubit.dart';
import 'package:eyeapp3d/layers/domain/entity/user.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:eyeapp3d/layers/domain/repository/user_repository.dart';
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
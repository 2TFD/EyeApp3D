import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

class FourImageCard extends StatelessWidget {
  FourImageCard({super.key, required this.list});
  List<String> list;

  @override
  Widget build(BuildContext context) {
    const snackBar = SnackBar(content: Text('сохранено'));
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Image.file(File(list[0])),
                                    Positioned(
                                      child: IconButton(
                                        onPressed: () {
                                          Gal.putImage(list[0]);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(snackBar);
                                        },
                                        icon: Icon(Icons.save_alt, size: 30),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () async {
                                          SharePlus.instance.share(
                                            ShareParams(
                                              files: [XFile(list[0])],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.ios_share, size: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.white,
                    child: Image.file(File(list[0])),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Image.file(File(list[1])),
                                    Positioned(
                                      child: IconButton(
                                        onPressed: () {
                                          Gal.putImage(list[1]);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(snackBar);
                                        },
                                        icon: Icon(Icons.save_alt, size: 30),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () async {
                                          SharePlus.instance.share(
                                            ShareParams(
                                              files: [XFile(list[1])],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.ios_share, size: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.white,
                    child: Image.file(File(list[1])),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Image.file(File(list[2])),
                                    Positioned(
                                      child: IconButton(
                                        onPressed: () {
                                          Gal.putImage(list[2]);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(snackBar);
                                        },
                                        icon: Icon(Icons.save_alt, size: 30),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () async {
                                          SharePlus.instance.share(
                                            ShareParams(
                                              files: [XFile(list[2])],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.ios_share, size: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.white,
                    child: Image.file(File(list[2])),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Image.file(File(list[3])),
                                    Positioned(
                                      child: IconButton(
                                        onPressed: () {
                                          Gal.putImage(list[3]);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(snackBar);
                                        },
                                        icon: Icon(Icons.save_alt, size: 30),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () async {
                                          SharePlus.instance.share(
                                            ShareParams(
                                              files: [XFile(list[3])],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.ios_share, size: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.white,
                    child: Image.file(File(list[3])),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

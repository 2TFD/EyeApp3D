import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/brand/price_list.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/provider/images_provider.dart';
import 'package:eyeapp3d/layers/domain/provider/model_provider.dart';
import 'package:eyeapp3d/layers/domain/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class PreviewScreen extends StatefulWidget {
  PreviewScreen({super.key, required this.image});

  XFile image;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('preview')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Image.file(File(widget.image.path))),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Directory dir = await getApplicationDocumentsDirectory();
                    int tokens = await UserProvider().getTokens();
                    if (tokens >= PriceList().model_gen) {
                      UserProvider().buyTokens(PriceList().model_gen);
                      // context.goNamed(
                      //   'view3d',
                      //   extra: {'par1': widget.image, 'par2': dir.path},
                      // );
                      context.push('/gen/camera/preview/view3d', extra: <String, dynamic>{
                        'fileImage': widget.image,
                        'dirPath' : dir.path,
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (context) => SimpleDialog(
                              backgroundColor: Colors.transparent,
                              title: Center(child: Text('no tokes(')),
                            ),
                      );
                    }
                  },
                  icon: Icon(Icons.check),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

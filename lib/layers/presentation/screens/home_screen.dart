import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/helpers.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/presentation/ui/image_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // example images
                        Container(color: Colors.amber, height: 50, width: 50),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text('привет!', style: Theme.of(context).textTheme.bodyLarge),
              Text('username', style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 40),
              Text(
                'твой токен: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              // CupertinoButton(
              //   child: Text('api get image'),
              //   onPressed: () async {
              //     await Api().imageGen('car');
              //   },
              // ),
              // CupertinoButton(
              //   child: Text('read'),
              //   onPressed: () async {
              //     print(await Storage().getListPhoto());
              //   },
              // ),
              // CupertinoButton(
              //   child: Text('del'),
              //   onPressed: () async {
              //     Storage().clearListPhoto();
              //   },
              // ),
              CupertinoButton(
                child: Text('getListImage'),
                onPressed: () async {
                  print(await Storage().getListImage());
                  List<List<String>> list = await Storage().getListImage();
                  // print(list);
                  // print(list[0][0]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

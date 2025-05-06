import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
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
          color: Colors.white,
        ),
        title: Text('home'),
      ),


      body: Padding(
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
                      Container(color: Colors.amber, height: 50,width: 50,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Text('привет!', style: TextStyle(color: Colors.white, fontSize: 20)),
            Text('username', style: TextStyle(color: Colors.white)),
            SizedBox(height: 40,),
            Text('твой токен: '),




            CupertinoButton(
              child: Text('read'),
              onPressed: () async {
                print(await Storage().getList());
              },
            ),
            CupertinoButton(
              child: Text('del'),
              onPressed: () async {
                Storage().clearList();
              },
            ),
          ],
        ),
      ),
    );
  }
}

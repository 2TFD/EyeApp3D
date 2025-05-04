import 'dart:io';

import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/presentation/ui/image_card.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Widget childW = Text('null');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('gallery')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
          });
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          future: Storage().readList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                childW = GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 2,
                  children:
                      (snapshot.data as List<String>).map((e) {
                        return ImageCard(fileImage: File(e));
                      }).toList(),
                );
              } else {
                childW = Center(child: Text('у вас нету фото'));
              }
            } else {
              childW = Center(child: CircularProgressIndicator());
            }
            return childW;
          },
        ),
      ),
    );
  }
}

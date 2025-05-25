import 'dart:io';

import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/presentation/ui/cards/image_card.dart';
import 'package:flutter/material.dart';

class GalleryModelsScreen extends StatefulWidget {
  GalleryModelsScreen({super.key});

  @override
  State<GalleryModelsScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryModelsScreen> {
  Widget childW = Text('null');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('gallery models')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          future: Storage().getListPhoto(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
              childW = Center(child: Text('null'));
            }
            return childW;
          },
        ),
      ),
    );
  }
}

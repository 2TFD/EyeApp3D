import 'dart:io';

import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/presentation/ui/cards/four_image_card.dart';
import 'package:eyeapp3d/layers/presentation/ui/cards/image_card.dart';
import 'package:flutter/material.dart';

class GalleryImagesScreen extends StatefulWidget {
  GalleryImagesScreen({super.key});

  @override
  State<GalleryImagesScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryImagesScreen> {
  Widget childW = Text('null');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('gallery images')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          future: Storage().getListImage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              childW = GridView.count(
                crossAxisCount: 1,
                children:
                    (snapshot.data as List<List<String>>).map((e) {
                      return Center(child: FourImageCard(list: e));
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

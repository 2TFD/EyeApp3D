import 'package:eyeapp3d/layers/domain/entity/images.dart';
import 'package:eyeapp3d/layers/domain/provider/images_provider.dart';
import 'package:eyeapp3d/layers/presentation/shared/ui/cards/four_image_card.dart';
import 'package:flutter/material.dart';

class GalleryImagesScreen extends StatefulWidget {
  const GalleryImagesScreen({super.key});
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
          future: ImagesProvider().getListImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              childW = GridView.count(
                crossAxisCount: 1,
                children:
                    (snapshot.data as List<Images>).map((e) {
                      return Center(child: FourImageCard(
                        promt: e.promt,
                        list: [
                        e.imagePathOne,
                        e.imagePathTwo,
                        e.imagePathThree,
                        e.imagePathFour,
                      ]));
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

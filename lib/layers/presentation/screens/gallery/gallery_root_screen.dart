import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryRootScreen extends StatelessWidget {
  const GalleryRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('gallery'),),
      body: Column(
        children: [
          GestureDetector(
            child: ListTile(title: Text('models'),),
            onTap: () => context.push('/gallery/gallerymodels'),
          ),
          GestureDetector(
            child: ListTile(title: Text('images'),),
            onTap: () => context.push('/gallery/galleryimages'),
          ),
        ],
      ),
    );
  }
}
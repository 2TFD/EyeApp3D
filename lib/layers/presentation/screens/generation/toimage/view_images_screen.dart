import 'package:eyeapp3d/layers/domain/provider/images_provider.dart';
import 'package:eyeapp3d/layers/presentation/shared/ui/cards/four_image_card.dart';
import 'package:flutter/material.dart';

class ViewImagesScreen extends StatefulWidget {
  const ViewImagesScreen({super.key, required this.promt});

  final String promt;

  @override
  State<ViewImagesScreen> createState() => _ViewImagesScreenState();
}

class _ViewImagesScreenState extends State<ViewImagesScreen> {
  Widget childW = Text('data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ImagesProvider().newImages(widget.promt),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            childW = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FourImageCard(
                  promt: widget.promt,
                  list: [
                    snapshot.data!.imagePathOne,
                    snapshot.data!.imagePathTwo,
                    snapshot.data!.imagePathThree,
                    snapshot.data!.imagePathFour,
                ]),
              ],
            );
          } else {
            childW = CircularProgressIndicator();
          }
          return Center(child: childW);
        },
      ),
    );
  }
}

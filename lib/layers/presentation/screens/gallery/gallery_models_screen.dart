import 'package:eyeapp3d/layers/domain/entity/model.dart';
import 'package:eyeapp3d/layers/domain/provider/model_provider.dart';
import 'package:eyeapp3d/layers/presentation/shared/ui/cards/image_card.dart';
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
      appBar: AppBar(
        title: Row(
          children: [
            Text('gallery models'),
            Spacer(),
            IconButton(
              onPressed: () async {
                await ModelProvider().delListModels();
                setState(() {});
              },
              icon: Icon(Icons.clear),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          future: ModelProvider().getListModels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              childW = GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
                children:
                    (snapshot.data as List<Model>).map((e) {
                      return ImageCard(model: e);
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

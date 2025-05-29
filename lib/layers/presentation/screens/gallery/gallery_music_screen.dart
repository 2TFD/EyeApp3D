import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/domain/provider/track_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryMusicScreen extends StatefulWidget {
  const GalleryMusicScreen({super.key});

  @override
  State<GalleryMusicScreen> createState() => _GalleryMusicScreenState();
}

class _GalleryMusicScreenState extends State<GalleryMusicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('music')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return Future<void>.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          // future: Storage().getListMusic(),
          future: TrackProvider().getListTracks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children:
                      snapshot.data!.map((e) {
                        return GestureDetector(
                          onTap:
                              () => context.push(
                                '/gen/music_promt/music_view',
                                extra: <String, dynamic>{
                                  'promt': e.promt,
                                  'style': e.style,
                                  'filePath': e.trackPath,
                                  'indexTrack': e,
                                },
                              ),
                          child: ListTile(
                            title: Text(e.promt),
                            subtitle: Text(e.style),
                          ),
                        );
                      }).toList(),
                ),
              );
            } else {
              return Center(child: Text('null'));
            }
          },
        ),
      ),
    );
  }
}

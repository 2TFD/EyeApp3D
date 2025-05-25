import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GenRootScreen extends StatelessWidget {
  const GenRootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [


            GestureDetector(
              onTap: () => context.go('/gen/camera'),
              child: ListTile(title: Text('3d gen'), subtitle: Text('photo to model'),)
            ),

            GestureDetector(
              onTap: () => context.go('/gen/getpromt'),
              child: ListTile(title: Text('image gen'), subtitle: Text('promt to images'),)
            ),

            GestureDetector(
              onTap: () => context.go('/gen/chat'),
              child: ListTile(title: Text('chat'), subtitle: Text('online chat'),)
            ),

            GestureDetector(
              onTap: () => context.go('/gen/music_promt'),
              child: ListTile(title: Text('music gen'), subtitle: Text('promt to music'),)
            ),
          ],
        ),
      ),
    );
  }
}
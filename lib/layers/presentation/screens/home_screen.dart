import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/core/helpers.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/presentation/ui/cards/image_card.dart';
import 'package:eyeapp3d/layers/presentation/ui/diologs/set_folder_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> ListAssetsForExample = ['assets/image/car.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.push('/settings'),
          icon: Icon(Icons.settings),
        ),
        title: Text('home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Привет!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SetFolderDialog(),
                  );
                },
                child: Text('data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

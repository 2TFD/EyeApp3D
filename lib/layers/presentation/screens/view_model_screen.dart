import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class ViewModelScreen extends StatefulWidget {
  ViewModelScreen({super.key, required this.fileImage, required this.dirPath});

  XFile? fileImage;
  String? dirPath;
  @override
  State<ViewModelScreen> createState() => _ViewModelScreenState();
}

class _ViewModelScreenState extends State<ViewModelScreen> {
  @override
  void initState() {
    print(widget.dirPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uri;
    Widget childW;
    return Scaffold(
      appBar: AppBar(title: Text('3d model')),
      body:
          !File(
                '${widget.dirPath}/${widget.fileImage!.name.replaceAll('.jpg', '.glb')}',
              ).existsSync()
              ? FutureBuilder(
                future: Api().addPhoto(widget.fileImage!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != 'error_from_api') {
                      uri = Uri.file(snapshot.data!).toString();
                      childW = ModelViewer(
                        src: uri,
                        alt: '3d model',
                        autoRotate: true,
                      );
                      return childW;
                    } else {
                      childW = Center(child: Text('попробуйте обновить токен', style: TextStyle(color: Colors.white),));
                    }
                  } else {
                    childW = CircularProgressIndicator();
                  }
                  return childW;
                },
              )
              : ModelViewer(
                src:
                    Uri.file(
                      '${widget.dirPath}/${widget.fileImage!.name.replaceAll('.jpg', '.glb')}',
                    ).toString(),
                alt: '3d model',
                autoRotate: true,
              ),
    );
  }
}

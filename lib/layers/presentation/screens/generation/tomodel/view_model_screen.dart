import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/local/storage.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text('3d model')),
          body:
              !File(
                    '${widget.dirPath}/${widget.fileImage!.name.replaceAll('.jpg', '.glb')}',
                  ).existsSync()
                  ? FutureBuilder(
                    future: Api().modelGen(widget.fileImage!),
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
                          childW = Center(
                            child: Text(
                              'попробуйте обновить токен',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }
                      } else {
                        childW = Center(child: CircularProgressIndicator());
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
                    backgroundColor: const Color.fromARGB(255, 45, 75, 109),
                  ),
        ),
        Positioned(
          top: 70,
          right: 25,
          child: IconButton(
            onPressed: () async {
              await FilePicker.platform.saveFile(
                dialogTitle: 'Please select an output file:',
                fileName: '${widget.fileImage!.name.replaceAll('.jpg', '.glb')}',
                bytes: await File('${widget.dirPath}/${widget.fileImage!.name.replaceAll('.jpg', '.glb')}').readAsBytes()
              );
              ;
            },
            icon: Icon(Icons.download),
          ),
        ),
      ],
    );
  }
}

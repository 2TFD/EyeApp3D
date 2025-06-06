import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/provider/model_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ViewModelScreen extends StatefulWidget {
  ViewModelScreen({super.key, required this.fileImage, required this.dirPath});

  XFile fileImage;
  String dirPath;
  @override
  State<ViewModelScreen> createState() => _ViewModelScreenState();
}

class _ViewModelScreenState extends State<ViewModelScreen> {

  @override
  Widget build(BuildContext context) {
    String uri;
    Widget childW;
    Widget positionedDownload = Positioned(
      top: 15,
      right: 25,
      child: IconButton(
        onPressed: () async {
          await FilePicker.platform.saveFile(
            dialogTitle: 'Please select an output file:',
            fileName: '${widget.fileImage!.name.replaceAll('.jpg', '.glb')}',
            bytes:
                await File(
                  '${widget.dirPath}/${widget.fileImage.name.replaceAll('.jpg', '.glb')}',
                ).readAsBytes(),
          );
          ;
        },
        icon: Icon(Icons.download),
      ),
    );
    Widget positionedShare = Positioned(
        top: 15,
        left: 25,
        child: IconButton(
          onPressed: () async {
            final res = await SharePlus.instance.share(
              ShareParams(
                files: [
                  XFile(
                    '${widget.dirPath}/${widget.fileImage.name.replaceAll('.jpg', '.glb')}',
                  ),
                ],
              ),
            );
          },
          icon: Icon(Icons.ios_share),
        ),
      );
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text('3d model')),
          body:
              !File(
                    '${widget.dirPath}/${widget.fileImage!.name.replaceAll('.jpg', '.glb')}',
                  ).existsSync()
                  ? FutureBuilder(
                    // future: Api().modelGen(widget.fileImage!),
                    future: ModelProvider().newModel(widget.fileImage!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != 'error_from_api') {
                          uri = Uri.file(snapshot.data!.modelPath).toString();
                          childW = Stack(
                            children: [
                              ModelViewer(
                                src: uri,
                                alt: '3d model',
                                autoRotate: true,
                                backgroundColor: Colors.black,
                              ),
                              positionedDownload,
                              positionedShare,
                            ],
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
                  : Stack(
                    children: [
                      ModelViewer(
                        src:
                            Uri.file(
                              '${widget.dirPath}/${widget.fileImage.name.replaceAll('.jpg', '.glb')}',
                            ).toString(),
                        autoRotate: true,
                      ),
                      positionedDownload,
                      positionedShare,
                    ],
                  ),
        ),
        //
      ],
    );
  }
}

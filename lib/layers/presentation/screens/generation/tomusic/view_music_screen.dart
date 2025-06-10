import 'dart:io';
import 'package:eyeapp3d/layers/domain/provider/track_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';

class ViewMusicScreen extends StatefulWidget {
  const ViewMusicScreen({
    super.key,
    required this.promt,
    required this.style,
    required this.filePath,
    required this.indexTrack,
  });
  final String style;
  final String promt;
  final String filePath;
  final String indexTrack;
  @override
  State<ViewMusicScreen> createState() => _ViewMusicScreenState();
}

class _ViewMusicScreenState extends State<ViewMusicScreen> {
  bool isPause = true;
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  int currentIndex = 0;
  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  void changePage(PageController pageController, int index) async {
    player.stop();
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void playPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  late List<AudioSource> playList;

  Future<void> selectTrack(int index) async {
    await player.setAudioSource(playList[index]);
  }

  @override
  void initState() {
    super.initState();
    playList = [AudioSource.file(widget.filePath)];

    if (widget.filePath != 'null') {
      player.positionStream.listen((p) {
        setState(() => position = p);
      });

      player.durationStream.listen((d) {
        if (d != null) {
          setState(() => duration = d!);
        } else {
          d = Duration(seconds: 0);
          setState(() => duration = d!);
        }
      });

      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            position = Duration.zero;
          });
          player.pause();
          player.seek(position);
          isPause = true;
        }
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget childW;
    // final player = AudioPlayer();
    return Scaffold(
      appBar: AppBar(),
      body:
          (widget.filePath == 'null' || widget.indexTrack == 'null')
              ? FutureBuilder(
                // future: Api().musicGen(widget.promt, widget.style),
                future: TrackProvider().newTrack(widget.promt, widget.style),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    childW = Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => context.push('/gallery/gallerymusic'),
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '${widget.promt}\n${widget.style}\ntap to see',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    childW = CircularProgressIndicator();
                  }
                  return Center(child: childW);
                },
              )
              : FutureBuilder(
                // future: Storage().getListMusic(),
                future: TrackProvider().getListTracks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    PageController pageController = PageController(
                      initialPage: int.parse(widget.indexTrack),
                    );
                    playList =
                        snapshot.data!.map((e) {
                          return AudioSource.file(e.trackPath);
                        }).toList();
                    childW = Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 250,
                            child: Expanded(
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: snapshot.data!.length,
                                onPageChanged: (index) async {
                                  setState(() {
                                    currentIndex = index;
                                    handleSeek(0.0);
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      color: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data![index].promt,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].style,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(snapshot.data![currentIndex].promt),
                                  Text(snapshot.data![currentIndex].style),
                                ],
                              ),
                              IconButton(
                                onPressed: () async {
                                  await FilePicker.platform.saveFile(
                                    dialogTitle:
                                        'Please select an output file:',
                                    fileName: 'track.wav',
                                    bytes:
                                        await File(
                                          snapshot.data![currentIndex].trackPath,
                                        ).readAsBytes(),
                                  );
                                },
                                icon: Icon(Icons.download),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await SharePlus.instance.share(
                                    ShareParams(
                                      files: [
                                        XFile(snapshot.data![currentIndex].trackPath),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.ios_share),
                              ),
                            ],
                          ),
                          Slider(
                            min: 0.0,
                            max: duration.inSeconds.toDouble(),
                            value: (0.0 <= position.inSeconds.toDouble() && position.inSeconds.toDouble() <= duration.inSeconds.toDouble())
                            ?position.inSeconds.toDouble()
                            :0.0,
                            onChanged: handleSeek,
                            thumbColor: Colors.white,
                            activeColor: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed:
                                    () => changePage(
                                      pageController,
                                      currentIndex - 1,
                                    ),
                                icon: Icon(Icons.arrow_left, size: 45),
                              ),
                              (isPause == false)
                                  ? IconButton(
                                    onPressed: () async {
                                      selectTrack(currentIndex);
                                      playPause();
                                      isPause = true;
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.pause, size: 30),
                                  )
                                  : IconButton(
                                    onPressed: () async {
                                      selectTrack(currentIndex);
                                      playPause();
                                      isPause = false;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.play_arrow_sharp,
                                      size: 30,
                                    ),
                                  ),
                              IconButton(
                                onPressed:
                                    () => changePage(
                                      pageController,
                                      currentIndex + 1,
                                    ),
                                icon: Icon(Icons.arrow_right, size: 45),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    childW = Center(child: CircularProgressIndicator());
                  }
                  return childW;
                },
              ),
    );
  }
}

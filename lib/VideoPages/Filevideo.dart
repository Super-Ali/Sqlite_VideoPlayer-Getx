import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

class FileVideo extends StatefulWidget {
  const FileVideo({Key? key}) : super(key: key);

  @override
  State<FileVideo> createState() => _FileVideoState();
}

class _FileVideoState extends State<FileVideo> {
  VideoPlayerController? controller;
  final buttonStyle =
      TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 22, 77, 87));
  File defaultvideo =
      File('/data/user/0/com.example.nav_app/cache/file_picker/videob.mp4');
  @override
  initState() {
    super.initState();
    controller = VideoPlayerController.file(defaultvideo)
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) => controller!.pause());
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          controller != null && controller!.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: GestureDetector(
                        onDoubleTap: () {
                          controller!.value.isPlaying
                              ? controller!.pause()
                              : null;
                        },
                        child: Stack(
                          children: [
                            VideoPlayer(controller!),
                          ],
                        ),
                      )),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      controller!.setVolume(controller!.value.volume - .1);
                    },
                    child: Icon(Icons.volume_down)),
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      controller!.setVolume(controller!.value.volume + .1);
                    },
                    child: Icon(Icons.volume_up)),
                ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      controller!.setVolume(0);
                    },
                    child: Icon(
                      Icons.volume_off,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              final file = await pickvideofile();
              if (file == null) return;

              controller = VideoPlayerController.file(file)
                ..addListener(() {
                  setState(() {});
                })
                ..initialize().then((_) => controller!.pause());
            },
            label: Text("Select from Sd Card"),
            icon: Icon(Icons.add),
            backgroundColor: Colors.cyan,
          )
        ],
      ),
    );
  }

  Future pickvideofile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    return File(result!.files.single.path!);
  }
}

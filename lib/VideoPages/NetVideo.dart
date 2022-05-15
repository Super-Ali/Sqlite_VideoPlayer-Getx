import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

var urlvid =
    'https://assets.mixkit.co/videos/preview/mixkit-going-down-a-curved-highway-down-a-mountain-41576-large.mp4';

class NetVideo extends StatefulWidget {
  const NetVideo({Key? key}) : super(key: key);

  @override
  State<NetVideo> createState() => _NetVideoState();
}

class _NetVideoState extends State<NetVideo> {
  VideoPlayerController? controller;
  TextEditingController texty = TextEditingController(text: urlvid);
  final buttonStyle =
      TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 22, 77, 87));
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(texty.text)
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: TextField(
                  controller: texty,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    controller = VideoPlayerController.network(texty.text)
                      ..addListener(() {
                        setState(() {});
                      })
                      ..initialize().then((_) => controller!.pause());
                  },
                  icon: Icon(Icons.update))
            ],
          )
        ],
      ),
    );
  }
}

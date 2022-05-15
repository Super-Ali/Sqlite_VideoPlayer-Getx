import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AssetVideo extends StatefulWidget {
  String asset;
  String name;

  AssetVideo(this.asset, this.name);

  @override
  State<AssetVideo> createState() => _AssetVideoState();

  void changeasset(address) {
    asset = address;
  }
}

class _AssetVideoState extends State<AssetVideo> {
  VideoPlayerController? controller;
  final buttonStyle =
      TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 22, 77, 87));
  bool showcontrolbar = true;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.asset)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) {
        controller!.pause();
        controller!.setVolume(0.05);
      });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => Container(
        child: Column(
          children: [
            controller != null && controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showcontrolbar
                              ? showcontrolbar = false
                              : showcontrolbar = true;
                        });
                        Future.delayed(Duration(seconds: 5))
                            .then((_) => showcontrolbar
                                ? setState(() {
                                    showcontrolbar = false;
                                  })
                                : null);
                      },
                      child: Stack(
                        children: [
                          VideoPlayer(controller!),
                          buildplay(),
                          showcontrolbar
                              ? Positioned(
                                  bottom: 34,
                                  right: 0,
                                  left: 0,
                                  child: Container(child: buildInddicator()))
                              : Container(),
                          showcontrolbar ? ControlsBar() : Container(),
                          showcontrolbar ? NameBar(widget.name) : Container(),
                        ],
                      ),
                    ))
                : Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  ),
          ],
        ),
      );
  Widget buildInddicator() => VideoProgressIndicator(
        controller!,
        colors: const VideoProgressColors(
            playedColor: Colors.green,
            backgroundColor: Color.fromARGB(255, 5, 199, 5),
            bufferedColor: Colors.black),
        allowScrubbing: true,
      );
  Widget ControlsBar() => Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            color: Color.fromARGB(169, 31, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller!.pause();
                  },
                  child: Icon(
                    Icons.pause_circle,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller!.play();
                  },
                  child: Icon(
                    Icons.play_circle,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller!.setVolume(controller!.value.volume - .1);
                  },
                  child: Icon(
                    Icons.volume_down_rounded,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller!.setVolume(controller!.value.volume + .1);
                  },
                  child: Icon(
                    Icons.volume_up_rounded,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller!.setVolume(0);
                  },
                  child: Icon(
                    Icons.volume_off_rounded,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.fullscreen_rounded,
                    color: Colors.green,
                  ),
                ),
              ],
            )),
      );
  Widget NameBar(name) => Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.all(8),
        color: Color.fromARGB(169, 31, 30, 30),
        child: Text(
          name,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ));
  Widget buildplay() => controller!.value.isPlaying
      ? Container()
      : Container(
          color: Color.fromARGB(83, 4, 73, 11),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () => controller!.play(),
            child: Icon(
              Icons.play_arrow,
              color: Colors.green,
              size: 50,
            ),
          ),
        );
}

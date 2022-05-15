import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_app/VideoPages/AssetVideo.dart';
import 'dart:io';

import 'package:nav_app/VideoPages/Filevideo.dart';
import 'package:nav_app/VideoPages/MediaVideoPlayer.dart';
import 'package:nav_app/VideoPages/NetVideo.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  Widget tabtitle(String title, IconData icon) => Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(132, 0, 0, 0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 3,
                offset: Offset(2, -5), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.greenAccent,
                size: 30,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/appbar.jpg'),
                        fit: BoxFit.cover)),
                child: SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FractionalTranslation(
                      translation: Offset(0, -0.3),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(172, 0, 0, 0),
                            border: Border.all(
                                width: 1, color: Colors.greenAccent)),
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "Cool Media Player",
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TabBar(
                        indicatorColor: Colors.greenAccent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: tabtitle('Video', Icons.tv),
                          ),
                          Tab(
                            child: tabtitle('Music', Icons.music_video),
                          ),
                          Tab(child: tabtitle('Photo', Icons.portrait))
                        ]),
                  ],
                )),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight * 2)),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Color.fromARGB(255, 1, 82, 5),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_label), label: "Multimedia"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.data_object), label: "States Database")
            ],
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/');
              }
              if (index == 1) {
                Navigator.pushNamed(context, '/videos');
              }
              if (index == 2) {
                Navigator.pushNamed(context, '/about');
              }
            },
            currentIndex: 1,
          ),
          body: TabBarView(children: [
            Container(color: Colors.black, child: MediaVideoPlayer()),
            Container(
                child: Column(
              children: [FileVideo()],
            )),
            Container(
              child: NetVideo(),
            ),
          ])),
    );
  }
}

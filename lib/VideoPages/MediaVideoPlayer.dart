import 'package:flutter/material.dart';
import 'package:nav_app/VideoPages/AssetVideo.dart';
import 'VideoList.dart';

class MediaVideoPlayer extends StatefulWidget {
  const MediaVideoPlayer({Key? key}) : super(key: key);

  @override
  State<MediaVideoPlayer> createState() => _MediaVideoPlayerState();
}

class _MediaVideoPlayerState extends State<MediaVideoPlayer> {
  @override
  Widget build(BuildContext context) => Navigator(
        initialRoute: 'videos/VideoRoute',
        onGenerateRoute: (RouteSettings setting) {
          WidgetBuilder builder;
          switch (setting.name) {
            case 'videos/VideoRoute':
              builder = (BuildContext context) => VideoRoute(
                    routeAdress: 'assets/vid1.mp4',
                    name: 'Urichi - The Greatest Shinobi',
                  );
              break;
            default:
              throw Exception('Invalid route: ${setting.name}');
          }
          return MaterialPageRoute<void>(builder: builder, settings: setting);
        },
      );
}

class VideoRoute extends StatefulWidget {
  VideoRoute({Key? key, this.routeAdress, this.name}) : super(key: key);
  var routeAdress;
  var name;

  @override
  State<VideoRoute> createState() => _VideoRouteState();
}

class _VideoRouteState extends State<VideoRoute> {
  TextEditingController urlController = TextEditingController();
  TextStyle wordstyle1 = TextStyle(color: Colors.green, fontSize: 15);
  TextStyle wordstyle2 = TextStyle(color: Colors.greenAccent, fontSize: 10);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AssetVideo(widget.routeAdress, widget.name),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Urlfield(), uploadButton()],
          ),
          SizedBox(
            height: 5,
          ),
          VideosPanel()
        ],
      );
  Widget Urlfield() => Flexible(
      flex: 4,
      child: Container(
        height: 50,
        padding: EdgeInsets.all(8),
        child: TextField(
          style: TextStyle(color: Colors.greenAccent),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {},
          controller: urlController,
          decoration: const InputDecoration(
              hintText: "Enter Url of Video",
              hintStyle: TextStyle(color: Colors.greenAccent),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 3)),
              contentPadding: EdgeInsets.only(left: 10)),
        ),
      ));
  Widget uploadButton() => Flexible(
      flex: 2,
      child: Container(
          child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.upload),
        label: Text("Upload"),
        style: TextButton.styleFrom(backgroundColor: Colors.green),
      )));
  Widget VideosPanel() => Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fiberbga.jpg'), fit: BoxFit.cover),
        ),
        child: ListView(
          children: VideoList.map((e) => ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(0, 0, 0, 0)),
                onPressed: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VideoRoute(
                              routeAdress: e['address'],
                              name: e['name'],
                            ))),
                child: ListTile(
                  focusColor: Colors.lightGreen,
                  title: Text(
                    e['name'],
                    style: wordstyle1,
                  ),
                  subtitle: Text(
                    e['detail'],
                    style: wordstyle2,
                  ),
                  leading: Image.asset(
                    e['thumbnail'],
                    scale: 0.5,
                  ),
                ),
              )).toList(),
        ),
      );
}

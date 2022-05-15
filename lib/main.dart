import 'package:flutter/material.dart';
import 'All.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const NavApp());
}

class NavApp extends StatelessWidget {
  const NavApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomeScreen(),
        '/videos': (BuildContext context) => const VideoPlayer(),
        '/about': (BuildContext context) => const About(),
      },
    );
  }
}

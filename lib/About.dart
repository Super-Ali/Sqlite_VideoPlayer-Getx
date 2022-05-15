import 'package:flutter/material.dart';
import 'package:nav_app/All.dart';
import 'package:nav_app/NestedPages/PageOne.dart';
import 'package:nav_app/NestedPages/PageTwo.dart';
import 'package:get/get.dart';
import 'NestedPages/NavController.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: inputDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBarbutton('DataBase', 'about/one', Icons.grid_goldenratio),
            AppBarbutton('Smoke', 'about/two', Icons.smoking_rooms)
          ],
        ),
        backgroundColor: Color.fromARGB(255, 185, 12, 12),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 185, 12, 12),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 90, 3, 3),
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
        currentIndex: 2,
      ),
      body: GetBuilder<NavController>(
        init: NavController(),
        builder: (_) => Navigator(
            pages: [
              if (_.navroute == 'about/one') MaterialPage(child: PageOne()),
              if (_.navroute == 'about/two') MaterialPage(child: PageTwo()),
            ],
            onPopPage: (route, result) {
              return route.didPop(result);
            }),
      ),
    );
  }
}

class AppBarbutton extends StatelessWidget {
  final buttonName;
  final buttonAdress;
  final IconData buttonIcon;
  const AppBarbutton(this.buttonName, this.buttonAdress, this.buttonIcon);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(buttonIcon),
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 90, 3, 3),
        ),
        onPressed: () {
          Get.find<NavController>().changeRoute(buttonAdress);
        },
        label: Text(buttonName));
  }
}

class inputDrawer extends StatelessWidget {
  const inputDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController subtitle = TextEditingController();
    String hint = '';
    return Drawer(
      backgroundColor: Color.fromARGB(255, 117, 12, 5),
      child: ListView(children: [
        Container(
          color: Color.fromARGB(255, 66, 6, 2),
          child: DrawerHeader(
              child: Row(
            children: const [
              Icon(
                Icons.table_bar,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Database Entries",
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              )
            ],
          )),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 10),
          child: Divider(
            color: Colors.redAccent,
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: inputField(title, 'Enter query title'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: inputField(subtitle, 'Enter Detail'),
        ),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(image: AssetImage('assets/mcqueen.png')),
        ),
      ]),
    );
  }
}

Widget inputField(TextEditingController info, String hint) {
  return TextField(
    style: TextStyle(color: Colors.red),
    textInputAction: TextInputAction.done,
    onSubmitted: (_) {
      print(info.text);
    },
    controller: info,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.red),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3)),
        contentPadding: const EdgeInsets.only(left: 10)),
  );
}

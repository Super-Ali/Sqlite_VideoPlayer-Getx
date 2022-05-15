import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nav_app/About.dart';
import 'package:nav_app/NestedPages/SpriteController.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fiberbgd.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.red, BlendMode.color)),
        ),
        child: DisplayArea(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionButton(Icons.keyboard_arrow_left,
              () => Get.find<PlayerMover>().moveLeft()),
          actionButton(Icons.keyboard_arrow_down,
              () => Get.find<PlayerMover>().moveDown()),
          actionButton(Icons.keyboard_arrow_right,
              () => Get.find<PlayerMover>().moveRight())
        ],
      ),
    );
  }
}

Widget actionButton(IconData myIcon, function) {
  return FloatingActionButton.extended(
    onPressed: function,
    label: Icon(
      myIcon,
      color: Color.fromARGB(255, 250, 191, 191),
    ),
    backgroundColor: Colors.red,
  );
}

class DisplayArea extends StatelessWidget {
  const DisplayArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 6,
            child: GetBuilder<PlayerMover>(
              init: PlayerMover(),
              builder: (_) => Container(
                color: Color.fromARGB(139, 0, 0, 0),
                child: Center(
                  child: Stack(children: [
                    Container(
                      alignment: Alignment(_.playerX, _.PlayerY),
                      child: mcQueen(),
                    )
                  ]),
                ),
              ),
            )),
        Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 32),
              child: actionButton(Icons.keyboard_arrow_up,
                  () => Get.find<PlayerMover>().moveUp()),
            ))
      ],
    );
  }
}

Widget mcQueen() {
  return GetBuilder<PlayerMover>(
    init: PlayerMover(),
    builder: (_) => Transform.rotate(
      angle: _.Rotation,
      child: GestureDetector(
        onTap: () {
          Get.find<PlayerMover>().rotate();
        },
        child: Container(
          height: 100,
          width: 100,
          child: Image(
            image: AssetImage('assets/mcqueen.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  );
}

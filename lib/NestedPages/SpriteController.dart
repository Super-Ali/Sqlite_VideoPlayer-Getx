import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerMover extends GetxController {
  double playerX = 0;
  double PlayerY = 1;
  double Rotation = 0.0;

  rotate() {
    Rotation = 0.0;
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      Rotation > 6.3 ? timer.cancel() : Rotation += 0.1;
      update();
    });
  }

  moveLeft() {
    playerX - 0.1 < -1 ? {} : playerX -= 0.1;
    update();
  }

  moveRight() {
    playerX + 0.1 > 1 ? {} : playerX += 0.1;
    update();
  }

  moveUp() {
    PlayerY - 0.1 < -1 ? {} : PlayerY -= 0.1;
    update();
  }

  moveDown() {
    PlayerY + 0.1 > 1 ? {} : PlayerY += 0.1;
    update();
  }
}

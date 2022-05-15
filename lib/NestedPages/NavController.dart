import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  String navroute = 'about/one';

  changeRoute(String newroute) {
    navroute = newroute;
    update();
  }
}

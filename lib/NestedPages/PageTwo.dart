import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nav_app/NestedPages/NavController.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavController disp = Get.put(NavController());
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/smoke01.gif'), fit: BoxFit.cover))),
    );
  }
}

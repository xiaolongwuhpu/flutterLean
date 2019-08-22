import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OpacityTrans extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OpacityTransState();
  }
}

class OpacityTransState extends State<OpacityTrans> with SingleTickerProviderStateMixin {
  GlobalKey globalKey = new GlobalKey();
  GlobalKey globalKey2 = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      home: new Scaffold(
        body: Container(
          alignment: Alignment(0, transAnimation.value),
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
//              MaterialButton(key:globalKey,onPressed: ()=>startDownload(),child: Text("开始下载"),),
//              MaterialButton(key:globalKey2,onPressed: ()=>startDownload(),child: Text("${(fadeAnimation.value*100).toInt()}"),),

                Icon(
                  Icons.camera,
                  color: Colors.orange,
                  size: 30,
                ),
                Icon(
                  Icons.camera,
                  color: Colors.orange,
                  size: 30,
                ),
                Icon(
                  Icons.camera,
                  color: Colors.orange,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: MaterialButton(
          onPressed: clickFloat,
          child: Text("$button"),
        ),
      ),
    );

    return app;
  }

  AnimationController controller;
  Animation<double> fadeAnimation;
  Animation<double> transAnimation;
  Animation<double> cuver;

  @override
  void initState() {
    initAnimtation();
  }

  String button = "开始";
  int state = 1;

  void clickFloat() {
    if (state == 1) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  void initAnimtation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);

    cuver = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    transAnimation = Tween(begin: 1.0, end: 0.6).animate(cuver);

    fadeAnimation.addListener(() {
      print("ttttttt    animation=${(fadeAnimation.value * 100).toInt()}");
      setState(() {});
    });
    fadeAnimation.addStatusListener((status) {
      print("ttttttt    animation=$status");
      if (status == AnimationStatus.completed) {
        button = "正向_动画完成";
      } else if (status == AnimationStatus.dismissed) {
        button = "反向_动画完成";
      } else if (status == AnimationStatus.forward) {
        state = 1;
      } else {
        state = 2;
      }
    });
    transAnimation.addStatusListener((status) {
      print("ttttttt    animation=$status");
      if (status == AnimationStatus.completed) {
//        button = "正向_动画完成";
      } else if (status == AnimationStatus.dismissed) {
//        button = "反向_动画完成";
      } else if (status == AnimationStatus.forward) {
//        state = 1;
      } else {
//        state = 2;
      }
    });
    controller.forward();
  }

  Offset offset;
}

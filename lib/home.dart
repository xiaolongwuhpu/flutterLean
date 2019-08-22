import 'package:flutter/material.dart';
import 'package:flutter_app/animation/OpacityTrans.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MainPageList.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return MainPageList();
  }
}


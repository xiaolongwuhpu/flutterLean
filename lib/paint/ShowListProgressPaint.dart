
import 'package:flutter/material.dart';

import 'TestProgressPaint.dart';

class ShowListProgressPaint extends StatefulWidget {
  @override
  _ShowListProgressPaintState createState() => _ShowListProgressPaintState();
}

class _ShowListProgressPaintState extends State<ShowListProgressPaint> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Column(children: <Widget>[
          TestProgressPaint(value: 0.4,),
          TestProgressPaint(),
          TestProgressPaint(value: 0.8,),

        ],),
      ),
    );
  }
}

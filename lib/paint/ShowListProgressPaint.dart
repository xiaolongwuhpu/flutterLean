import 'package:flutter/material.dart';
import 'package:flutter_app/paint/TestRotate.dart';

import 'CusProgressWidget.dart';
import 'CusProgressWidget90.dart';
import 'TestTextPaint.dart';
import 'WaveProgressWidget.dart';

class ShowListProgressPaint extends StatefulWidget {
  @override
  _ShowListProgressPaintState createState() => _ShowListProgressPaintState();
}

class _ShowListProgressPaintState extends State<ShowListProgressPaint>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                  animation: controller,
//                child:,
                  builder: (BuildContext context, Widget child) {
                    return Column(
                      children: <Widget>[
                        TextPaintWidget(),
//                        CusProgressWidget90(
//                          value: animation.value,
//                        ),
                        CusProgressWidget(
                          value: animation.value,
                        ),
                        WaveProgressWidget(
                          value: animation.value,
                        ),
                        TestRotate(
                          value: animation.value,
                        ),
                      ],
                    );
                  }),
//            CusProgressWidget(),
//            CusProgressWidget(
//              value: 0.8,
//            ),
            ],
          ),
        ),
      ),
      floatingActionButton: CircleAvatar(
        child: RaisedButton(
          onPressed: startAnim,
          shape: CircleBorder(),
          child: Text(
            "杀",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
//        setState(() {
////        print("ttt   value=${animation.value}");
//        });
      });
    controller.forward();
  }

  startAnim() {
    controller.forward(from: 0.0);
  }
}

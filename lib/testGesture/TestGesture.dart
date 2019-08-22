import 'package:flutter/material.dart';

void main() {
  runApp(TestGesture());
}

class TestGesture extends StatefulWidget {
  @override
  _TestGestureState createState() => _TestGestureState();
}

class _TestGestureState extends State<TestGesture> {
  double _x = 200;
  double _y = 200;

  double _wx = 100;
  double _wy = 100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onPanStart: (DragStartDetails start) {
          setState(() {
            _wx = start.localPosition.dx;
            _wy = start.localPosition.dy;
            print("w update = ${start.localPosition.toString()}");
          });
        },
        onPanUpdate: (DragUpdateDetails update) {
          setState(() {
            _wx = update.localPosition.dx;
            _wy = update.localPosition.dy;
            print("w update = ${update.delta.toString()}");
          });
        },
        onPanEnd: (DragEndDetails end) {
          print("wend ${end.toString()}");
        },
        onPanCancel: () {},
        onPanDown: (DragDownDetails down) {
          print("wdown ${down.localPosition}");
        },
        child: Stack(
          children: <Widget>[
            Positioned(
                top: _y,
                left: _x,
                child: GestureDetector(
                    onPanStart: (DragStartDetails start) {
                      print("start = ${start.toString()}");
                    },
                    onPanUpdate: (DragUpdateDetails update) {
                      setState(() {
                        _x += update.delta.dx;
                        _y += update.delta.dy;
                      });
                    },
                    onPanEnd: (DragEndDetails end) {},
                    onPanCancel: () {},
                    onPanDown: (DragDownDetails down) {
                      print("down ${down.toString()}");
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xffff0000),
                      radius: 30,
                    ))),
            Positioned(
              left: _wx,
              top: _wy,
              child: CircleAvatar(
                backgroundColor: Color(0xff00ddcc),
                radius: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

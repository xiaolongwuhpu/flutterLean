import 'package:flutter/material.dart';

class SlideScale extends StatelessWidget {
  final int count;
  final Size size;

  SlideScale({@required this.count, @required this.size});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomPaint(
        size: size,
        painter: new ScalePainter(
          count: count,
        ),
      ),
    );
  }
}

class ScalePainter extends CustomPainter {
  final int count;
  ScalePainter({this.count});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.black12;
    paint.strokeWidth = 1;

    double interval = size.width / count;
    for (int i = 0; i < count; i++) {
      double x = i * interval;
      canvas.drawLine(Offset(x, 0.0), Offset(x, 6.0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

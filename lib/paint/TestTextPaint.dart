import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';

void main() => runApp(MaterialApp(home: TextPaintWidget()));

///画一个渐变的圆形进度条
class TextPaintWidget extends StatefulWidget {
  TextPaintWidget();

  @override
  _TextPaintWidgetState createState() => _TextPaintWidgetState();
}

class _TextPaintWidgetState extends State<TextPaintWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 150,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: CustomPaint(
        size: Size(50, 150),
        painter: CusTextPaint(),
      ),
    );
  }
}

class CusTextPaint extends CustomPainter {
  ///粗细
  final double stokeWidth;

  CusTextPaint({
    Key key,
    this.stokeWidth = 5.0,
  }) : super() {
    linePaint = Paint();
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
  }

  Paint linePaint;
  TextPainter textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    linePaint
      ..color = Colors.orange
      ..strokeWidth = stokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    ///原始坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(-50, 10)],
        linePaint
          ..color = Colors.orange
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    textPainter
      ..text = new TextSpan(
        text: "原始坐标",
        style: TextStyleUtils.boldStyle(
          ColorEnum.blue,
          fontSize: 14.0,
        ),
      );

    textPainter.layout();
    textPainter.paint(
        canvas,
        new Offset((size.width / 2) - (textPainter.width / 2),
            -linePaint.strokeWidth / 2));
    textPainter
      ..text = new TextSpan(
        text: "变动后的坐标",
        style: TextStyleUtils.boldStyle(
          ColorEnum.blue,
          fontSize: 14.0,
        ),
      );

    textPainter.layout();

    linePaint
      ..color = Colors.black
      ..shader = null
      ..strokeWidth = stokeWidth;

    ///平移后的坐标原点
    canvas.drawPoints(PointMode.points,
        [Offset(-50, textPainter.height + stokeWidth / 2)], linePaint);
    textPainter.paint(
        canvas,
        new Offset((size.width / 2) - (textPainter.width / 2),
            textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

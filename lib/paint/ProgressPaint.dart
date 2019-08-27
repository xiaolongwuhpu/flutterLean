
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
//import 'dart:math' as math;

import 'package:flutter_app/style/CommonStyle.dart';

class ProgressPaint extends CustomPainter {
  /// 圆的半径
  final double radius;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;
  final List<Color> colors;

  ///粗细
  final double stokeWidth;

  ProgressPaint({
    Key key,
    this.colors,
    this.radius,
    this.value,
    this.totalAngle = pi * 2,
    this.backgroundColor,
    this.stokeWidth,
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
    double startAngle = 0 /*-math.pi / 2*/;
    double endAngle = value * totalAngle;

    ///坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(0, 0)],
        linePaint
          ..color = Colors.orange
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    linePaint
      ..color = backgroundColor
      ..strokeWidth = stokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    ///画背景
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius, linePaint);

    Rect rect = Offset(0, 0) & Size(size.width, size.height);

    linePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: endAngle,
        colors: colors,
      ).createShader(rect)
      ..isAntiAlias = true;
    canvas.drawArc(rect, startAngle, endAngle, false, linePaint);

    textPainter
      ..text = new TextSpan(
        text: "${(value * 100).toInt()}%",
        style: TextStyleUtils.boldStyle(
          ColorEnum.blue,
          fontSize: 28.0,
        ),
      );

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(pi / 2);
    canvas.translate(-size.width / 2, -size.height / 2);
    textPainter.layout();
    textPainter.paint(
        canvas,
        new Offset((size.width / 2) - (textPainter.width / 2),
            (size.height / 2) - (textPainter.height / 2)));
    canvas.restore();

    ///移动后的坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(0, 0)],
        linePaint
          ..color = Colors.black
          ..strokeWidth = stokeWidth
          ..shader = null
          ..strokeCap = StrokeCap.round);

//canvas.save();
    canvas.rotate(pi / 2);
    textPainter
      ..text = new TextSpan(
        text: "方案一",
        style: TextStyleUtils.boldStyle(
          ColorEnum.blue,
          fontSize: 14.0,
        ),
      );
    textPainter.layout();
    textPainter.paint(
        canvas,
        new Offset((size.width / 2) - (textPainter.width / 2),
            -(size.height) - textPainter.height));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';

void main() => runApp(MaterialApp(home: CusProgressWidget()));

///画一个渐变的圆形进度条
class CusProgressWidget extends StatefulWidget {
  CusProgressWidget(
      {this.stokeWidth = 5.0,
      this.radius = 50,
      this.colors = const [Colors.blue, Colors.orangeAccent, Colors.red],
      this.stops,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFDEDEDE),
      this.totalAngle = math.pi * 2,
      this.value = 0.6});

  ///粗细
  final double stokeWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应colors属性
  final List<double> stops;

  @override
  _CusProgressWidgetState createState() => _CusProgressWidgetState();
}

class _CusProgressWidgetState extends State<CusProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: 150,
      color: Color(0x33000000),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: CustomPaint(
        size: Size.fromRadius(widget.radius),
        painter: ProgressPaint2(
            colors: widget.colors,
            radius: widget.radius,
            value: widget.value,
            totalAngle: widget.totalAngle,
            backgroundColor: widget.backgroundColor,
            stokeWidth: widget.stokeWidth),
      ),
    );
  }
}

class ProgressPaint2 extends CustomPainter {
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

  ProgressPaint2({
    Key key,
    this.colors,
    this.radius,
    this.value,
    this.totalAngle = math.pi * 2,
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
    double startAngle = 0.0 /*-math.pi / 2*/;
    double endAngle = value * totalAngle;
    linePaint
      ..color = backgroundColor
      ..strokeWidth = stokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    ///原始坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(0, 0)],
        linePaint
          ..color = Colors.orange
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    linePaint
      ..color = backgroundColor
      ..strokeWidth = stokeWidth;

    ///画背景
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius, linePaint);

    Rect rect = Offset(0, 0) & Size(size.width, size.height);
//    canvas.drawRect(rect, linePaint);
    linePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: endAngle,
        colors: colors,
      ).createShader(rect)
      ..isAntiAlias = true;
    canvas.save();
    canvas.translate(0.0, size.width);
    canvas.rotate(-math.pi / 2);
    canvas.drawArc(rect, startAngle, endAngle, false, linePaint);
    linePaint
      ..color = Colors.black
      ..shader = null
      ..strokeWidth = stokeWidth;

    ///平移后的坐标原点
    canvas.drawPoints(PointMode.points, [Offset(0, 0)], linePaint);

    textPainter
      ..text = new TextSpan(
        text: "${(value * 100).toInt()}%",
        style: TextStyleUtils.boldStyle(
          ColorEnum.blue,
          fontSize: 28.0,
        ),
      );
//    canvas.drawColor(Color(0x99ff6699), BlendMode.color);
    canvas.restore();
    textPainter.layout();
    textPainter.paint(
        canvas,
        new Offset((size.width / 2) - (textPainter.width / 2),
            (size.height / 2) - (textPainter.height / 2)));

    textPainter
      ..text = new TextSpan(
        text: "方案二",
        style: TextStyleUtils.boldStyle(
          ColorEnum.blue,
          fontSize: 14.0,
        ),
      );
    textPainter.layout();
    textPainter.paint(
        canvas,
        new Offset((size.width / 2) - (textPainter.width / 2),
            -(textPainter.height + 5)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

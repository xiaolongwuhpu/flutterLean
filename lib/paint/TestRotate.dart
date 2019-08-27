import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';

void main() => runApp(MaterialApp(home: TestRotate()));

///画一个渐变的圆形进度条
class TestRotate extends StatefulWidget {
  TestRotate(
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
  _TestRotateState createState() => _TestRotateState();
}

class _TestRotateState extends State<TestRotate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: 200,
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

  Color backgroundColor, waveColor, borderColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;
  final List<Color> colors;

  ///粗细
  final double stokeWidth;

  ProgressPaint2({
    Key key,
    this.colors,
    this.radius,
    this.waveColor = const Color(0x550033ee),
    this.borderColor = Colors.orange,
    this.value,
    this.totalAngle = math.pi * 2,
    this.backgroundColor,
    this.stokeWidth,
  }) : super() {
    wavePaint = Paint();
    backgroundPaint = Paint();
    borderPaint = Paint()..color = Colors.orange;
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
  }

  Paint wavePaint, backgroundPaint, borderPaint;
  TextPainter textPainter;

  @override
  void paint(Canvas canvas, Size size) {

    ///正方形宽高 = 圆的直径
    double recHeight = 100;
    double recWidth = 100;
    ///(正方形) 正菱形 对角线长度
    double diagonalRhombuslength = math.sqrt(math.pow(recWidth, 2) + math.pow(recHeight, 2));
    borderPaint
      ..color = backgroundColor
      ..strokeWidth = stokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    ///原始坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(0, 0)],
        borderPaint
          ..color = Colors.orange
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round);
    borderPaint
      ..color = backgroundColor
      ..strokeWidth = stokeWidth;

    ///画背景
//    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, borderPaint);

//    canvas.save();
    canvas.translate(recHeight / 2, recHeight / 2);
    canvas.rotate(-math.pi / 4);
    canvas.translate(-recHeight / 2, -recHeight / 2);
//    Rect rect = Offset(0, 0) & Size(recHeight, recHeight);
    Rect rect = Rect.fromLTWH(0, 0, recWidth, recHeight);
    canvas.drawRect(rect, borderPaint);
//    canvas.save();

    ///滑动后坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(0, 0)],
        borderPaint
          ..color = Colors.black
          ..strokeWidth = stokeWidth
          ..strokeCap = StrokeCap.round);

    ///滑动后坐标原点
    canvas.drawPoints(
        PointMode.points,
        [Offset(size.width, size.height)],
        borderPaint
          ..color = Colors.black
          ..strokeWidth = stokeWidth
          ..strokeCap = StrokeCap.round);

    backgroundPaint
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.rotate(math.pi / 4);
    canvas.translate(0, -diagonalRhombuslength/2);
    double baseLineHeight = (1 - value) * diagonalRhombuslength;
    canvas.save();
    double totleWaveHeight = 8;
    Path path = Path();
    if(value<0.5){
      path.moveTo(diagonalRhombuslength*(0.5-value), baseLineHeight);
//      for (double i = 0.0; i < diagonalRhombuslength; i++) {
//        path.lineTo(diagonalRhombuslength/2 * i*(value),baseLineHeight +math.sin((i / diagonalRhombuslength * math.pi * 2) +(value * math.pi * 8)) * totleWaveHeight /2);
//      }
      path.lineTo(diagonalRhombuslength/2 + diagonalRhombuslength*(value), baseLineHeight);
    }else{
      path.moveTo(0, diagonalRhombuslength/2);
      path.lineTo(diagonalRhombuslength*(value-0.5), baseLineHeight);

//      for (double i = 0.0; i < diagonalRhombuslength; i++) {
//        path.lineTo(/*diagonalRhombuslength/2 + */((diagonalRhombuslength/2))*(value-0.5),baseLineHeight +math.sin((i / diagonalRhombuslength * math.pi * 2) +(value * math.pi * 8)) * totleWaveHeight /2);
//      }

      path.lineTo(diagonalRhombuslength - diagonalRhombuslength*(value-0.5), baseLineHeight);

      path.lineTo(diagonalRhombuslength, diagonalRhombuslength/2);
    }
    path.lineTo(diagonalRhombuslength / 2, diagonalRhombuslength);
    path.close();
    wavePaint..color = waveColor;
    canvas.restore();

    ///画波浪线
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

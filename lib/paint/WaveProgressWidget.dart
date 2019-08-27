import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';

///画一个渐变的圆形进度条
class WaveProgressWidget extends StatefulWidget {
  WaveProgressWidget(
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
  _WaveProgressWidgetState createState() => _WaveProgressWidgetState();
}

class _WaveProgressWidgetState extends State<WaveProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: 150,
      color: Color(0x33000000),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ClipPath(
        clipper: CircleClipper(),
        child: CustomPaint(
          size: Size.fromRadius(widget.radius),
          painter: ProgressPaint2(
              radius: widget.radius,
              value: widget.value,
              backgroundColor: widget.backgroundColor,
              stokeWidth: widget.stokeWidth),
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(new Rect.fromCircle(
          center: new Offset(size.width / 2, size.height / 2),
          radius: size.width / 2));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ProgressPaint2 extends CustomPainter {
  /// 圆的半径
  final double radius;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;
  Color backgroundColor, waveColor, borderColor;

  ///粗细
  final double stokeWidth;

  ProgressPaint2({
    Key key,
    this.waveColor = const Color(0x550033ee),
    this.borderColor = Colors.orange,
    this.radius = 50,
    this.value,
    this.backgroundColor = Colors.grey,
    this.stokeWidth = 5.0,
  }) : super() {
    wavePaint = Paint();
    backgroundPaint = Paint();
    borderPaint = Paint()..color=Colors.orange;
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
  }

  Paint wavePaint, backgroundPaint,borderPaint;
  TextPainter textPainter;

  @override
  void paint(Canvas canvas, Size size) {
//    /// Draw background
//    Paint backgroundPaint = Paint()
//      ..color = this.backgroundColor
//      ..style = PaintingStyle.fill;
//
//    Offset center = Offset(size.width / 2, size.height / 2);
//    double radius = math.min(size.width / 2, size.height / 2);
//
//    canvas.drawCircle(center, radius, backgroundPaint);
//
//    /// Draw wave
//    Paint wavePaint = new Paint()..color = waveColor;
//    double amp = 5.0;
//    double baseHeight = (1 - value) * size.height;
//
//    Path path = Path();
//    path.moveTo(0.0, baseHeight);
//    for (double i = 0.0; i < size.width; i++) {
//      path.lineTo(
//          i,
//          baseHeight +
//              sin((i / size.width * 2 * pi) + (value * 8* pi)) *
//                  amp);
//    }
//
//    path.lineTo(size.width, size.height);
//    path.lineTo(0.0, size.height);
//    path.close();
//    canvas.drawPath(path, wavePaint);


    backgroundPaint
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Offset center = Offset(size.width / 2, size.height / 2);
    ///drawCircle背景
    canvas.drawCircle(center, size.width, backgroundPaint);

    double baseLineHeight = (1-value)*size.height;
    double totleWaveHeight = 8;

    Path path = Path();
    path.moveTo(0.0, baseLineHeight);
    for(double i=0.0;i<size.width;i++){
      path.lineTo(i,baseLineHeight + math.sin((i/size.width *math.pi*2) + (value*math.pi*8))*totleWaveHeight/2);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    wavePaint..color = waveColor;
    ///画波浪线
    canvas.drawPath(path, wavePaint);

    borderPaint..style = PaintingStyle.stroke..strokeWidth = 5;
    ///画圆的border
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}




import 'package:flutter/material.dart' hide Gradient;
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TestProgressPaint()));

///画一个渐变的圆形进度条
class TestProgressPaint extends StatefulWidget {

  TestProgressPaint({
    this.stokeWidth = 5.0,
    this.radius=50,
    this.colors = const [Colors.blue,Colors.orangeAccent,Colors.red],
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFDEDEDE),
    this.totalAngle = 2 * pi,
    this.value=0.6
  });
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
  _TestProgressPaintState createState() => _TestProgressPaintState();
}

class _TestProgressPaintState extends State<TestProgressPaint> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Transform.rotate(
        angle: -pi/2,
        child: CustomPaint(
          size: Size.fromRadius(widget.radius),
          painter: ProgressPaint(colors:widget.colors,radius:widget.radius,value:widget.value,totalAngle:widget.totalAngle,backgroundColor:widget.backgroundColor,stokeWidth:widget.stokeWidth),
        ),
      ),
    );
  }
}

class  ProgressPaint extends CustomPainter{
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
  ProgressPaint({List<Color> this.colors, double this.radius, double this.value, double this.totalAngle, Color this.backgroundColor, this.stokeWidth,});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = backgroundColor..strokeWidth = stokeWidth
      ..isAntiAlias = true
    ..style = PaintingStyle.stroke;
    ///画背景
    canvas.drawCircle(Offset(size.width/2,size.height/2) , radius,paint);

    Rect rect = Offset(0, 0) & Size(
        size.width ,
        size.height
    );

    paint..style = PaintingStyle.stroke
      ..strokeWidth = stokeWidth
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle:  value*totalAngle,
        colors: colors,
//        stops: const <double>[0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(rect)
      ..isAntiAlias = true;
    canvas.drawArc(rect, 0, value*totalAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this==oldDelegate;
  }


}

import 'package:flutter/material.dart' hide Gradient;
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'ProgressPaint.dart';

void main() => runApp(MaterialApp(home: CusProgressWidget90()));

///画一个渐变的圆形进度条
class CusProgressWidget90 extends StatefulWidget {
  CusProgressWidget90(
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
  _CusProgressWidget90State createState() => _CusProgressWidget90State();
}

class _CusProgressWidget90State extends State<CusProgressWidget90> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: 150,
      color: Color(0x33000000),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Transform.rotate(
        angle: -math.pi / 2,
        child: CustomPaint(
          size: Size.fromRadius(widget.radius),
          painter: ProgressPaint(
              colors: widget.colors,
              radius: widget.radius,
              value: widget.value,
              totalAngle: widget.totalAngle,
              backgroundColor: widget.backgroundColor,
              stokeWidth: widget.stokeWidth),
        ),
      ),
    );
  }
}

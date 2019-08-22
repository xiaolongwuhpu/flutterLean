


import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(home: TestGomokuPaint()));

///画一个五子棋棋盘
class TestGomokuPaint extends StatefulWidget {
  @override
  _TestGomokuPaintState createState() => _TestGomokuPaintState();
}

class _TestGomokuPaintState extends State<TestGomokuPaint> {
  @override
  Widget build(BuildContext context) {
   double width =  MediaQuery.of(context).size.width;
    return Center(
      child: CustomPaint(
        size: Size(width-20, width-20),
        painter: GomokuPaint(),
      ),
    );
  }
}

class  GomokuPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width/15;
    double eHeight = size.height/15;

    Paint paint = Paint()
    ..color = Color(0xFFFFD180)
    ..style = PaintingStyle.fill;
    ///画背景
    canvas.drawRect( Offset.zero & size , paint);

    paint..style = PaintingStyle.stroke
    ..color = Colors.black87
    ..isAntiAlias = true;

    ///画线条
    for(int i=0;i<15;i++){
      double currentHeight = i*eHeight;
      canvas.drawLine(Offset(0, currentHeight),Offset(size.width, currentHeight), paint);
      double currentWidth = i*eWidth;
      canvas.drawLine(Offset(currentWidth, 0),Offset(currentWidth, size.height), paint);
    }
    paint..color = Colors.black
    .. style = PaintingStyle.fill;
    ///开始画棋子了
    canvas.drawCircle(Offset(size.width/2 - eWidth/2, size.width/2-eWidth/2), min(eWidth / 2, eHeight / 2) - 2, paint);

    paint..color = Colors.white
      .. style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width/2 + eWidth/2, size.width/2-eWidth/2), min(eWidth / 2, eHeight / 2) - 2, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this==oldDelegate;
  }


}

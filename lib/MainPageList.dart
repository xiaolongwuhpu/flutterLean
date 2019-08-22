import 'package:flutter/material.dart';
import 'package:flutter_app/animation/OpacityTrans.dart';
import 'package:flutter_app/paint/ShowListProgressPaint.dart';
import 'package:flutter_app/paint/TestGomokuPaint.dart';
import 'package:flutter_app/testdownload/TestDownLoad.dart';

import 'animation/FadeInOutWidget.dart';
import 'animation/TweenTransform.dart';
import 'lottie/TestLottie.dart';
import 'style/CommonStyle.dart';
import 'testGesture/TestGesture.dart';

class MainPageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageListState();
  }
}

class MainPageListState extends State<MainPageList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      home: new Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            commonWidget("下载", () => pushTo(TestDownLoad())),line(),
            commonWidget("FadeInOutWidget", () => pushTo(FadeInOutWidget())),line(),
            commonWidget("OpacityTrans", () => pushTo(OpacityTrans())),line(),
            commonWidget("testGesture", () => pushTo(TestGesture())),line(),
            commonWidget("testLottie", () => pushTo(TestLottie())),  line(),
            commonWidget("TweenTransform", () => pushTo(TweenTransform())), line(),
            commonWidget("五子棋棋盘", () => pushTo(TestGomokuPaint())), line(),
            commonWidget("圆形进度条", () => pushTo(ShowListProgressPaint())), line(),
          ],
        ),
      ),
    );
    return app;
  }

  @override
  void initState() {}

  Widget line() {
    return Divider(
      height: 5,
      color: EaseColors.dividerColor,
    );
  }

  Widget commonWidget(String string, Function function,{ Gradient gradient,double radius=8}) {
    return Container(
      height: 40,
      width: 130,
      decoration: BoxDecorationUtils.box(gradient: gradient??BoxDecorationUtils.bGradient(),radius: radius),
      child: AnimatedContainer(
        color: Colors.transparent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: Material(
          borderRadius:BorderRadius.all(Radius.circular(radius)) ,
          color: Colors.transparent,
          child: InkWell(
            radius: radius,
            onTap:function,
            child: Center(
                child: Text(
              string,
              style:TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )),
          ),
        ),
      ),
    );
  }

  pushTo(Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

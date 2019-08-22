import 'dart:async';

import 'package:flutter/material.dart';

class FadeInOutWidget extends StatefulWidget {
  List<String> list;

  FadeInOutWidget({this.list});

  @override
  _FadeInOutWidgetState createState() => _FadeInOutWidgetState();
}

class _FadeInOutWidgetState extends State<FadeInOutWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FadeTransition(
          opacity: _animation, child: Image.network(widget.list[index])),
    );
  }
  ///角标索引值
  int index = 0;

  @override
  void initState() {
    super.initState();
    if(widget.list==null || widget.list.length==0){
      widget.list.add("https://dmpcdn.ksmobile.com/cloud/test/1608/cS7O2FLV2H_1554801266/z1A7xMZjTJ_1554806785/m33IV3T6ddYB0f97WY4rS30XzsLYu8Az_1555579051.jpg");
      widget.list.add("https://dmpcdn.ksmobile.com/cloud/test/1608/O6QzWnjc0N_1552298403/ZIcLVg8dpI_1555579146/Z86Y8Ex1cfy72l6Pa9B7d4oq2Vk468tz_1555580719.jpg");
      widget.list.add("https://dmpcdn.ksmobile.com/cloud/test/1608/O6QzWnjc0N_1552298403/6K947tJUvg_1555579159/U2386G633mGb9o2ZgwAKTgZZ4hjSmVUh_1555580573.jpg");
    }

    _initPlayerWidgetAnim();
    startTimer();
  }

  ///-----------------timer定时器,用于确定图片是否播放完成-------------
  Timer _timer;

  /// 总的时间秒数
  int totleSeconds = 5;

  /// 当前倒计时的秒数。
  int currentTimerSeconds = 0;

  void startTimer({int totleTime, int currentTime}) {
    cancelTimer();
    if (totleTime != null) {
      totleSeconds = totleTime;
    }
    if (currentTime != null) {
      currentTimerSeconds = currentTime;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentTimerSeconds == totleSeconds) {
        index++;
        if (index > widget.list.length - 1) {
          index = 0;
        }
        currentTimerSeconds = 0;
        dismissPlayerWidget();
        return;
      }
      currentTimerSeconds++;
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }

  /// 取消倒计时的计时器。
  void cancelTimer() {
    if (_timer != null && _timer.isActive) _timer?.cancel();
  }

  void cancelTimerAndReset() {
    currentTimerSeconds = 0;
    if (_timer != null && _timer.isActive) _timer?.cancel();
  }

  /// -------------淡入淡出动画 -------------------------
  AnimationController _controller;
  Animation _animation;

  ///初始化动画
  void _initPlayerWidgetAnim() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.addStatusListener((value) {
      if (value == AnimationStatus.completed) {
      } else if (value == AnimationStatus.dismissed) {
        setState(() {});
        showPlayerWidget();
      }
    });
    showPlayerWidget();
  }

  ///正向 开始动画
  showPlayerWidget() {
    _controller.forward();
  }

  ///反向 动画
  dismissPlayerWidget() {
    _controller.reverse();
  }
}

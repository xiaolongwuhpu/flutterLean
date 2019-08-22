import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';
import 'package:flutter_app/xslider/SlideCutomeTheme.dart';
import 'package:flutter_app/xslider/select_time_dialog_v2.dart';

void main() => runApp(TestSlider());

class TestSlider extends StatefulWidget {
  @override
  _TestSliderState createState() => _TestSliderState();
}

class _TestSliderState extends State<TestSlider> {
  double value = 6.0;
  ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xE9FFFFFF),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            select_time_dialog_v2(context),
            Container(
              height: 160,
              alignment: Alignment(0, 0),
              child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      trackHeight: 5,
                      inactiveTrackColor: EaseColors.transparentWhite25,
                      activeTickMarkColor: EaseColors.COLOR_FFFF8C66,
                      inactiveTickMarkColor: EaseColors.COLOR_FF95E6BE,
                      //提示进度的气泡的背景色
                      valueIndicatorColor: Colors.green,
                      thumbColor: Colors.red,
                      //提示进度的气泡文本的颜色
                      valueIndicatorTextStyle: TextStyle(
                        color: Color(0x47242a33),
                      ),
                      thumbShape: CustomThumbForTimerSelectShape(),
                      trackShape: RoundRectangularSliderTrackShape(),
                      valueIndicatorShape: CustomValueIndicatorShape(),
                      showValueIndicator: ShowValueIndicator.always),
                  child: Slider(
                      value: value,
                      min: 0.0,
                      max: 12.0,
                      label: "${value.toInt()} H",
//                      divisions: 12,
                      activeColor: EaseColors.COLOR_FF4DA6FF,
                      inactiveColor: EaseColors.thirdFontColor,
                      onChangeEnd: (double newValue) {
                        value = newValue;
                      },
                      onChanged: (double newValue) {
                        value = newValue;
                        setState(() {});
                      })),
            )
          ],
        ),
      ),
    );
  }
}

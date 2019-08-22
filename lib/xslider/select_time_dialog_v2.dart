
import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';
import 'package:flutter_app/xslider/slide_scale.dart';

import 'SlideCutomeTheme.dart';

class select_time_dialog_v2 extends StatefulWidget {
  BuildContext context;

  select_time_dialog_v2(this.context);

  @override
  State<StatefulWidget> createState() {
    return new _StateContentW(context);
  }
}

class _StateContentW extends State<select_time_dialog_v2> {
  BuildContext context;
  int _currentIntValue1 = 00;
  int _currentIntValue2 = 30;

  _StateContentW(this.context);

  _handleValueChanged(double value) {
    if (value != null) {
      setState(() => _currentIntValue1 = value.toInt());
    }
  }

  _handleValueChanged2(double value) {
    if (value != null) {
      setState(() => _currentIntValue2 = value.toInt());
    }
  }

  TextStyle _titleStyle =
      TextStyle(color: Colors.white, fontSize: 36, fontStyle: FontStyle.normal);

  Widget _buildTitle() {
    return Text(
      'How long do you want to play?',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSliderItem() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 5,
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
                overlayColor: Colors.transparent,
                //提示进度的气泡的背景色
                valueIndicatorColor: Colors.green,
            overlappingShapeStrokeColor:Colors.blue,
                //提示进度的气泡文本的颜色
                valueIndicatorTextStyle: TextStyle(
                  color:Color(0x47242a33),
                ),
                valueIndicatorShape: CustomThumbShapeForRecommond(),
                showValueIndicator: ShowValueIndicator.always,
                thumbShape: CustomThumbShapeForSelectTime(),
                trackShape: RoundRectangularSliderTrackShape(),
//                valueIndicatorShape: CustomValueIndicatorShape(),
              ),
              child: Slider(
                value: _currentIntValue1.toDouble(),
                min: 0,
                max: 11,
                label: '$_currentIntValue1 h',
                onChanged: _handleValueChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: SlideScale(
                size: Size(300, 20),
                count: 12,
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5,
                inactiveTrackColor: Colors.black26,
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
                overlayColor: Colors.transparent,
                valueIndicatorColor: Colors.black87,
                valueIndicatorTextStyle: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
                showValueIndicator: ShowValueIndicator.always,
                thumbShape: CustomThumbShapeForSelectTime(),
                trackShape: RoundRectangularSliderTrackShape(),
//                valueIndicatorShape: CustomValueIndicatorShape(),
              ),
              child: new Slider(
                value: _currentIntValue2.toDouble(),
                min: 0,
                max: 59,
                label: '$_currentIntValue2 min',
                onChanged: _handleValueChanged2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: SlideScale(
                size: Size(300, 20),
                count: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYesBtn() {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pop('$_currentIntValue1,$_currentIntValue2'),
      child: Container(
        height: 50,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(50)),
          gradient: LinearGradient(
              colors: [const Color(0xFF5B9AD9), const Color(0xFF72C7F2)]),
        ),
        child: Center(
            child: Text(
          "CONFIRM",
          style: _titleStyle.copyWith(fontSize: 14),
        )),
      ),
    );
  }

  Widget _buildNoBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 50,
          color: Theme.of(context).dialogBackgroundColor,
          child: Center(
            child: Text(
              "CANCEL",
              style: _titleStyle.copyWith(color: Colors.black45, fontSize: 14),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).dialogBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        clipBehavior: Clip.antiAlias,
        type: MaterialType.card,
        child: Container(
            color: EaseColors.mainFontColor,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                _buildSliderItem(),
                _buildYesBtn(),
                _buildNoBtn(),
              ],
            )));
  }
}

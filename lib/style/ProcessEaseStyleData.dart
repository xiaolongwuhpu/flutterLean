
import 'package:flutter/material.dart';

import 'CommonStyle.dart';

///样式主题数据处理
class ProcessEaseStyleData{

  ///颜色反转的工具类
  static Color reverse(Color color){
    return Color.fromARGB(color.alpha, 255-(color.red * 0.8).toInt(), 255-(color.green * 0.8).toInt(), 255 -(color.blue * 0.8).toInt());
  }

  static Color transColor(ColorEnum normalColor, Color otherColor) {
    if(normalColor==ColorEnum.mainFontColor){
      return EaseColors.mainFontColor;
    }else if(normalColor==ColorEnum.secondFontColor){
      return EaseColors.secondFontColor;
    }else if(normalColor==ColorEnum.thirdFontColor){
      return EaseColors.thirdFontColor;
    }else if(normalColor==ColorEnum.reverseColor){
      return  EaseColors.white;
    }else if(normalColor==ColorEnum.blue){
      return  EaseColors.blue;
    }else if(normalColor==ColorEnum.useOther){///如果是需要其他颜色,就用otherColor的值,这个属性不要乱用,用多了就不好维护样式了,切记!!!
      return otherColor;
    }
    return EaseColors.mainFontColor;
  }
}
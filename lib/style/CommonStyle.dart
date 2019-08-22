
import 'package:flutter/material.dart';

import 'ProcessEaseStyleData.dart';
///以color的16进制命名,颜色相近的可以统一为一个颜色,避免颜色冗余过多
///没有UI特殊的说明,不要往里边添加颜色值
///没有UI特殊的说明,不要往里边添加颜色值
///没有UI特殊的说明,不要往里边添加颜色值
class  EaseColors {
  static  Color transparent10 = Color(0x1A000000);//0.1
  ///弹框蒙层颜色
  static  Color transparentBlack25 = Color(0x40000000);//0.25
  static  Color transparentWhite25 = Color(0x40ffffff);//0.25


  static  Color disableBtnColor = Color(0xFFCDD2D9);//按钮不可用状态颜色


  static  Color transparent87 = Color(0xDEFFFFFF);//0.87

  static  Color dividerColor = Color(0x1A242A33); /// 分割线颜色

  static  Color mainBackGroundColor = Color(0xFFF7F9FA);///主背景颜色

  static  Color mainFontColor = Color(0xDE242A33);///字体 黑色  主色
  static  Color secondFontColor = Color(0x80242A33);///字体 深灰
  static  Color thirdFontColor = Color(0x47242A33);///字体 浅灰
  static  Color white = Color(0xFFFFFFFF);   ///字体 白色
  static  Color blue = Color(0xFF66B3FF);///字体 蓝色
  static  Color transparent= Colors.transparent;


  /// start//////////以下为统一渐变样式,没有UI特殊的说明,不要往里边添加渐变///////
  /// 黄色渐变色
  static const Color COLOR_FFFFECB3 = Color(0xFFF7D198);   ///left
  static const Color COLOR_FFFF8C66 = Color(0xFFFF9A86);   ///right
  /// 蓝色渐变色
  static const Color COLOR_FF91E2F2 = Color(0xFF91E2F2);   ///left
  static const Color COLOR_FF4DA6FF = Color(0xFF4DA6FF);   ///right
  /// 蓝紫色渐变色
  static const Color COLOR_FFFF80E0 = Color(0xFFF9AEE0);   ///left
  static const Color COLOR_FF6699FF = Color(0xFF6699FF);   ///right
  /// 绿色渐变色
  static const Color COLOR_FF95E6BE = Color(0xFF95E6BE);   ///left
  static const Color COLOR_FF66BBCC = Color(0xFF66BBCC);   ///right
  /// 灰色渐变色
  static const Color COLOR_FFDFE6EB = Color(0xFFDFE6EB);   ///left
  static const Color COLOR_FFADB8C2 = Color(0xFFADB8C2);   ///right

  ///黄色渐变
  static const List<Color> GradientYellowColors = [COLOR_FFFFECB3, COLOR_FFFF8C66];
  ///蓝色渐变
  static const List<Color> GradientBlueColors = [COLOR_FF4DA6FF, COLOR_FF91E2F2];
  ///蓝紫色渐变
  static const List<Color> GradientBluePurpleColors = [COLOR_FFFF80E0, COLOR_FF6699FF];
  ///绿色渐变
  static const List<Color> GradientGreenColors = [COLOR_FF95E6BE, COLOR_FF66BBCC];
  ///灰色渐变色
  static const List<Color> GradientGrayColors = [COLOR_FFDFE6EB, COLOR_FFADB8C2];

  ///这个一般作为item上的蒙层的渐变
  static const List<Color> GradientOnImage = <Color>[ Colors.transparent,const Color(0x00242A33),const Color(0xaa242A33)];

  /// end /////////////////////////////////////////////////////////////////////

  //目前 只有录音波浪线用,暂时放在这里
  static const Color COLOR_FFB33167 = Color(0xffB33167);

  static Color convertColor(String hex, {int alpha= 0x70}) {
    if(hex != null && hex.startsWith("#") && hex.length>=6){
      int val = 0;
      String hext = hex.replaceAll("#", "FF").toUpperCase();
      int len = hext.length;
      for (int i = 0; i < len; i++) {
        int hexDigit = hext.codeUnitAt(i);
        if (hexDigit >= 48 && hexDigit <= 57) {
          val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
        } else if (hexDigit >= 65 && hexDigit <= 70) {
          // A..F
          val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
        } else {
          print("Invalid hexadecimal value");
        }
      }
      return Color(val).withAlpha(alpha);
    } else {
      print("invalid input str, could not convert to color!!!! + ${hex}");
      return Colors.black.withAlpha(0x26);
    }
  }

  static Color darkMixColor(Color c1, Color c2){
    int a = c1.alpha * c2.alpha ~/255;
    int r = c1.red * c2.red ~/255;
    int g = c1.green * c2.green ~/255;
    int b = c1.blue * c2.blue ~/255;
    return Color.fromARGB(a, r, g, b);
  }

  static Color mixColor(Color c1, Color c2, double radio) {
    int alpha = (c1.alpha * radio + c2.alpha * (1 - radio)).toInt();
    int red = (c1.red * radio + c2.red * (1 - radio)) .toInt();
    int green = (c1.green * radio + c2.green * (1 - radio)).toInt();
    int blue = (c1.blue * radio + c2.blue * (1 - radio)) .toInt();

    return Color.fromARGB(alpha, red, green, blue);
  }
}


///////////////////////////////////////////////////
/// 字体样式,目前先这么多,以后需要再添加参数
///////////////////////////////////////////////////
class TextStyleUtils {
   ///fontWeight ,fontFamily 使用默认的就行
  static  TextStyle normalStyle(ColorEnum normalColor,{Color otherColor,double fontSize = 12, fontStyle = FontStyle.normal, double wordSpacing = 1,String fontFamily="Archivo",FontWeight fontWeight=FontWeight.w300,}) {
    return _commonTextStyle.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      wordSpacing: wordSpacing,
      fontFamily:fontFamily,
      fontStyle: fontStyle,
      color:ProcessEaseStyleData.transColor(normalColor, otherColor??EaseColors.mainFontColor),);
  }
  ///fontWeight,fontFamily 使用默认的就行
  static  TextStyle boldStyle (ColorEnum normalColor,{ Color otherColor,double fontSize=20,fontStyle= FontStyle.normal,double wordSpacing= 1,String fontFamily="Archivo",FontWeight fontWeight=FontWeight.w700,}){
    return _commonTextStyle.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      wordSpacing: wordSpacing,
      fontFamily:fontFamily,
      fontStyle: fontStyle,
      color: ProcessEaseStyleData.transColor(normalColor, otherColor??EaseColors.mainFontColor),);
  }
  static TextStyle _commonTextStyle = TextStyle(
    height: 1.3,
    letterSpacing: 0.25,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w300,);
 }


////////////////////////////////////////////////////
/// BoxDecoration 样式util
////////////////////////////////////////////////////
 class  BoxDecorationUtils{
   //公共的渐变样式
   static Gradient CommonGradient({List<Color> colors=EaseColors.GradientBlueColors,AlignmentGeometry begin = Alignment.centerLeft, AlignmentGeometry end = Alignment.centerRight}) {
     return LinearGradient(
         begin: begin,
         end: end,
         colors: colors);
   }

  ///boxShadow 是否是显示阴影,  radius 弧度,
   static BoxDecoration box({Gradient gradient,bool boxShadow=false,DecorationImage image,double radius=8,Color color,BoxBorder border,BoxShape shape}) {
     return BoxDecoration(
       borderRadius: shape==BoxShape.circle?null: BorderRadius.all(
         Radius.circular(radius??8),
       ),
       boxShadow: boxShadow?[
         BoxShadow(
             color: Color(0x1A242A33),
             offset: Offset(0.0, 12.0),
             blurRadius: 24.0,
             spreadRadius: 0),
       ]:null,
         gradient: gradient??null,
         image: image??null,
         color: color??null,
         border: border??null,
         shape: shape??BoxShape.rectangle
     );
   }


   //蓝色渐变
   static Gradient bGradient({AlignmentGeometry begin = Alignment.centerLeft, AlignmentGeometry end = Alignment.centerRight}) {
     return CommonGradient(
         begin: begin,
         end: end,
         colors: EaseColors.GradientBlueColors);
   }

   //黄色渐变
   static Gradient yGradient({AlignmentGeometry begin = Alignment.centerLeft, AlignmentGeometry end = Alignment.centerRight}) {
     return CommonGradient(
         begin: begin,
         end: end,
         colors: EaseColors.GradientYellowColors);
   }

 }
class EaseStyle{
  static String light = "light";
  static String dark = "dark";
}

///如果不确定使用哪一个颜色的话先看下EaseColors.mainFontColor ,secondFontColor... 对应的16进制颜色
enum ColorEnum{
  mainFontColor, ///主色
  secondFontColor,
  thirdFontColor,
  reverseColor,/// 跟主字体色 相反的颜色, 如:当主字体颜色为黑色, COLOR_REVERSE就是白色,有些背景下用这个字体颜色
  blue,
  useOther,  ///这个表示用其他的颜色, 此时应该用otherColor这个颜色属性,这个属性不要乱用,用多了就不好维护样式了,切记!!!
}

enum ThemeStyle{
  light,
  dark,
}
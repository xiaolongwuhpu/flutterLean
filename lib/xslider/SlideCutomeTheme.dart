import 'package:flutter/material.dart';
import 'package:flutter_app/style/CommonStyle.dart';
import 'dart:math' as math;

///自定义slide属性类
class CustomThumbShapeForRecommond extends SliderComponentShape {
  static const double _thumbSize = 0.1;
  static const double _disabledThumbSize = 0.1;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final Offset offsetCenter = Offset(0, 0);
    final progressPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = EaseColors.thirdFontColor;

    canvas.drawCircle(offsetCenter, 1, progressPaint);
  }
}

//时间选择slider
class CustomThumbShapeForSelectTime extends SliderComponentShape {
  static const double _thumbSize = 8.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  @override
  void paint(
      PaintingContext context,
      Offset thumbCenter, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    final Canvas canvas = context.canvas;

    final Rect rect = Rect.fromCircle(center: thumbCenter, radius: _thumbSize);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(2));
    final progressPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    Path path = Path()..addRect(rect);
    canvas.drawShadow(path, Colors.black, 3, true);
    canvas.drawRRect(rRect, progressPaint);
  }
}

class LineSliderTickMarkShape extends SliderTickMarkShape {
  const LineSliderTickMarkShape({ this.tickMarkRadius });
  final double tickMarkRadius;
  @override
  Size getPreferredSize({
    bool isEnabled,
    SliderThemeData sliderTheme,
  }) {
    return Size.fromHeight(tickMarkRadius ?? sliderTheme.trackHeight * 2);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        Animation<double> enableAnimation,
        TextDirection textDirection,
        Offset thumbCenter,
        bool isEnabled,
      }) {
    Color begin;
    Color end;
    switch (textDirection) {
      case TextDirection.ltr:
        final bool isTickMarkRightOfThumb = center.dx > thumbCenter.dx;
        begin = isTickMarkRightOfThumb ? sliderTheme.disabledInactiveTickMarkColor : sliderTheme.disabledActiveTickMarkColor;
        end = isTickMarkRightOfThumb ? sliderTheme.inactiveTickMarkColor : sliderTheme.activeTickMarkColor;
        break;
      case TextDirection.rtl:
        final bool isTickMarkLeftOfThumb = center.dx < thumbCenter.dx;
        begin = isTickMarkLeftOfThumb ? sliderTheme.disabledInactiveTickMarkColor : sliderTheme.disabledActiveTickMarkColor;
        end = isTickMarkLeftOfThumb ? sliderTheme.inactiveTickMarkColor : sliderTheme.activeTickMarkColor;
        break;
    }
    final Paint paint = Paint()..color = ColorTween(begin: begin, end: end).evaluate(enableAnimation);

    final double tickMarkRadius = getPreferredSize(
      isEnabled: isEnabled,
      sliderTheme: sliderTheme,
    ).width / 2;
    context.canvas.drawCircle(center, tickMarkRadius, paint);
  }
}

class CustomThumbForTimerSelectShape extends SliderComponentShape {
  static const double half_height = 9;
  static const double half_width = 35;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromHeight(half_height * 2)
        : const Size.fromWidth(half_width * 2);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: half_width,
    end: half_height,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final progressPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white70;
    final rect = Rect.fromLTRB(
        thumbCenter.dx - half_width,
        thumbCenter.dy - half_height,
        thumbCenter.dx + half_width,
        thumbCenter.dy + half_height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(29));
    canvas.drawRRect(rRect, progressPaint);

    final Tween<double> slideUpTween = Tween<double>(
      begin: 0.0,
      end: 17,
    );

    final Offset slideUpOffset =
    Offset(0.0, -slideUpTween.evaluate(activationAnimation));

    labelPainter.paint(
        canvas,
        thumbCenter +
            slideUpOffset +
            Offset(-labelPainter.width / 2.0, -labelPainter.height/2.0));
  }
}

class CustomCircleThumbShape extends SliderComponentShape {
  static const double _thumbSize = 8.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    final Offset offsetCenter = Offset(thumbCenter.dx, thumbCenter.dy);
    final progressPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = EaseColors.mainFontColor;

    canvas.drawCircle(offsetCenter, 8, progressPaint);
  }
}

class CustomValueIndicatorShape extends SliderComponentShape {
  static const double _indicatorSize = 4.0;
  static const double _disabledIndicatorSize = 3.0;
  static const double _slideUpHeight = 15.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled ? _indicatorSize : _disabledIndicatorSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledIndicatorSize,
    end: _indicatorSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final Tween<double> slideUpTween = Tween<double>(
      begin: 0.0,
      end: _slideUpHeight,
    );

    final Offset slideUpOffset =
        Offset(0.0, -slideUpTween.evaluate(activationAnimation));
    labelPainter.paint(
        canvas,
        thumbCenter +
            slideUpOffset +
            Offset(-labelPainter.width / 2.0, -labelPainter.height - 4.0));
  }
}

class RoundRectangularSliderTrackShape extends SliderTrackShape {
  const RoundRectangularSliderTrackShape({this.disabledThumbGapWidth = 2.0});

  final double disabledThumbGapWidth;

  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled,
    bool isDiscrete,
  }) {
    final double overlayWidth =
        sliderTheme.overlayShape.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= overlayWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + overlayWidth / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;

    final double trackWidth = parentBox.size.width - overlayWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    Animation<double> enableAnimation,
    TextDirection textDirection,
    Offset thumbCenter,
    bool isDiscrete,
    bool isEnabled,
  }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final Gradient Leftgradient = new LinearGradient(
      colors: [EaseColors.COLOR_FF4DA6FF, EaseColors.COLOR_FF91E2F2],
    );

    double horizontalAdjustment = 0.0;
    if (!isEnabled) {
      final double disabledThumbRadius =
          sliderTheme.thumbShape.getPreferredSize(false, isDiscrete).width /
              2.0;
      final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
      horizontalAdjustment = disabledThumbRadius + gap;
    }

    final Rect trackRect = getPreferredRect(
        parentBox: parentBox,
        offset: offset,
        sliderTheme: sliderTheme,
        isEnabled: isEnabled,
        isDiscrete: isDiscrete);
    Radius radius = Radius.circular(5);
    final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left, trackRect.top,
        thumbCenter.dx - horizontalAdjustment, trackRect.bottom);
    final Rect rightTrackSegment = Rect.fromLTRB(
        thumbCenter.dx + horizontalAdjustment,
        trackRect.top,
        trackRect.right,
        trackRect.bottom);
    RRect rleftRect = RRect.fromRectAndRadius(leftTrackSegment, radius);
    RRect rrightRect = RRect.fromRectAndRadius(rightTrackSegment, radius);

//  final ColorTween activeTrackColorTween = ColorTween(begin: EaseColors.COLOR_FF4DA6FF , end:  EaseColors.COLOR_FF91E2F2);
//  final ColorTween inactiveTrackColorTween = ColorTween(begin: Color(0xff000000) , end: EaseColors.COLOR_47242A33);
    final Paint activePaint =
        Paint() /*..color = activeTrackColorTween.evaluate(enableAnimation)*/
          ..shader = Leftgradient.createShader(leftTrackSegment)
          ..strokeCap = StrokeCap.round;
//  final Paint inactivePaint = Paint()..shader=Rightgradient.createShader(rightTrackSegment)..strokeCap=StrokeCap.round;
    final Paint inactivePaint = Paint()
      ..color = EaseColors.thirdFontColor
      ..strokeCap = StrokeCap.round;
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }
    context.canvas.drawRRect(rleftRect, leftTrackPaint);
    context.canvas.drawRRect(rrightRect, rightTrackPaint);
  }
}

class CustomRoundSliderOverlayShape extends SliderComponentShape {
  /// Create a slider thumb overlay that draws a circle.
  const CustomRoundSliderOverlayShape({ this.overlayRadius = 24.0 });

  /// The preferred radius of the round thumb shape when enabled.
  ///
  /// If it is not provided, then half of the track height is used.
  final double overlayRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(overlayRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        @required Animation<double> activationAnimation,
        @required Animation<double> enableAnimation,
        bool isDiscrete = false,
        @required TextPainter labelPainter,
        @required RenderBox parentBox,
        @required SliderThemeData sliderTheme,
        @required TextDirection textDirection,
        @required double value,
      }) {
    assert(context != null);
    assert(center != null);
    assert(activationAnimation != null);
    assert(enableAnimation != null);
    assert(labelPainter != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(textDirection != null);
    assert(value != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: 0.0,
      end: overlayRadius,
    );

    canvas.drawCircle(
      center,
      radiusTween.evaluate(activationAnimation),
      Paint()..color = Colors.red,
    );
  }
}


/// 上方气泡
class CustomPaddleSliderValueIndicatorShape extends SliderComponentShape {
  /// Create a slider value indicator in the shape of an upside-down pear.
  const CustomPaddleSliderValueIndicatorShape();

  static const _PaddleSliderTrackShapePathPainter _pathPainter = _PaddleSliderTrackShapePathPainter();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete, { @required TextPainter labelPainter }) {
    assert(labelPainter != null);
    return _pathPainter.getPreferredSize(isEnabled, isDiscrete, labelPainter);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        @required Animation<double> activationAnimation,
        @required Animation<double> enableAnimation,
        bool isDiscrete,
        @required TextPainter labelPainter,
        @required RenderBox parentBox,
        @required SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    assert(context != null);
    assert(center != null);
    assert(activationAnimation != null);
    assert(enableAnimation != null);
    assert(labelPainter != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    final ColorTween enableColor = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.valueIndicatorColor,
    );
    _pathPainter.drawValueIndicator(
      parentBox,
      context.canvas,
      center,
      Paint()..color = enableColor.evaluate(enableAnimation),
      activationAnimation.value,
      labelPainter,
      null,
    );
  }
}



class _PaddleSliderTrackShapePathPainter {
  const _PaddleSliderTrackShapePathPainter();

  // These constants define the shape of the default value indicator.
  // The value indicator changes shape based on the size of
  // the label: The top lobe spreads horizontally, and the
  // top arc on the neck moves down to keep it merging smoothly
  // with the top lobe as it expands.

  // Radius of the top lobe of the value indicator.
  static const double _topLobeRadius = 16.0;
  // Designed size of the label text. This is the size that the value indicator
  // was designed to contain. We scale it from here to fit other sizes.
  static const double _labelTextDesignSize = 14.0;
  // Radius of the bottom lobe of the value indicator.
  static const double _bottomLobeRadius = 6.0;
  // The starting angle for the bottom lobe. Picked to get the desired
  // thickness for the neck.
  static const double _bottomLobeStartAngle = -1.1 * math.pi / 4.0;
  // The ending angle for the bottom lobe. Picked to get the desired
  // thickness for the neck.
  static const double _bottomLobeEndAngle = 1.1 * 5 * math.pi / 4.0;
  // The padding on either side of the label.
  static const double _labelPadding = 8.0;
  static const double _distanceBetweenTopBottomCenters = 40.0;
  static const Offset _topLobeCenter = Offset(0.0, -_distanceBetweenTopBottomCenters);
  static const double _topNeckRadius = 14.0;
  // The length of the hypotenuse of the triangle formed by the center
  // of the left top lobe arc and the center of the top left neck arc.
  // Used to calculate the position of the center of the arc.
  static const double _neckTriangleHypotenuse = _topLobeRadius + _topNeckRadius;
  // Some convenience values to help readability.
  static const double _twoSeventyDegrees = 3.0 * math.pi / 2.0;
  static const double _ninetyDegrees = math.pi / 2.0;
  static const double _thirtyDegrees = math.pi / 6.0;
  static const double _preferredHeight = _distanceBetweenTopBottomCenters + _topLobeRadius + _bottomLobeRadius;
  // Set to true if you want a rectangle to be drawn around the label bubble.
  // This helps with building tests that check that the label draws in the right
  // place (because it prints the rect in the failed test output). It should not
  // be checked in while set to "true".
  static const bool _debuggingLabelLocation = false;

  static Path _bottomLobePath; // Initialized by _generateBottomLobe
  static Offset _bottomLobeEnd; // Initialized by _generateBottomLobe

  Size getPreferredSize(
      bool isEnabled,
      bool isDiscrete,
      TextPainter labelPainter,
      ) {
    assert(labelPainter != null);
    final double labelHalfWidth = labelPainter.width / 2.0;
    return Size((labelHalfWidth + _topLobeRadius) * 2, _preferredHeight);
  }

  // Adds an arc to the path that has the attributes passed in. This is
  // a convenience to make adding arcs have less boilerplate.
  static void _addArc(Path path, Offset center, double radius, double startAngle, double endAngle) {
    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
    path.arcTo(arcRect, startAngle, endAngle - startAngle, false);
  }

  // Generates the bottom lobe path, which is the same for all instances of
  // the value indicator, so we reuse it for each one.
  static void _generateBottomLobe() {
    const double bottomNeckRadius = 4.5;
    const double bottomNeckStartAngle = _bottomLobeEndAngle - math.pi;
    const double bottomNeckEndAngle = 0.0;

    final Path path = Path();
    final Offset bottomKnobStart = Offset(
      _bottomLobeRadius * math.cos(_bottomLobeStartAngle),
      _bottomLobeRadius * math.sin(_bottomLobeStartAngle) - 2,
    );
    final Offset bottomNeckRightCenter = bottomKnobStart +
        Offset(
          bottomNeckRadius * math.cos(bottomNeckStartAngle),
          -bottomNeckRadius * math.sin(bottomNeckStartAngle),
        );
    final Offset bottomNeckLeftCenter = Offset(
      -bottomNeckRightCenter.dx,
      bottomNeckRightCenter.dy,
    );
    final Offset bottomNeckStartRight = Offset(
      bottomNeckRightCenter.dx - bottomNeckRadius,
      bottomNeckRightCenter.dy,
    );
    path.moveTo(bottomNeckStartRight.dx, bottomNeckStartRight.dy);
    _addArc(
      path,
      bottomNeckRightCenter,
      bottomNeckRadius,
      math.pi - bottomNeckEndAngle,
      math.pi - bottomNeckStartAngle,
    );
    _addArc(
      path,
      Offset.zero,
      _bottomLobeRadius,
      _bottomLobeStartAngle,
      _bottomLobeEndAngle,
    );
    _addArc(
      path,
      bottomNeckLeftCenter,
      bottomNeckRadius,
      bottomNeckStartAngle,
      bottomNeckEndAngle,
    );

    _bottomLobeEnd = Offset(
      -bottomNeckStartRight.dx,
      bottomNeckStartRight.dy,
    );
    _bottomLobePath = path;
  }

  Offset _addBottomLobe(Path path) {
    if (_bottomLobePath == null || _bottomLobeEnd == null) {
      // Generate this lazily so as to not slow down app startup.
      _generateBottomLobe();
    }
    path.extendWithPath(_bottomLobePath, Offset.zero);
    return _bottomLobeEnd;
  }

  // Determines the "best" offset to keep the bubble on the screen. The calling
  // code will bound that with the available movement in the paddle shape.
  double _getIdealOffset(
      RenderBox parentBox,
      double halfWidthNeeded,
      double scale,
      Offset center,
      ) {
    const double edgeMargin = 4.0;
    final Rect topLobeRect = Rect.fromLTWH(
      -_topLobeRadius - halfWidthNeeded,
      -_topLobeRadius - _distanceBetweenTopBottomCenters,
      2.0 * (_topLobeRadius + halfWidthNeeded),
      2.0 * _topLobeRadius,
    );
    // We can just multiply by scale instead of a transform, since we're scaling
    // around (0, 0).
    final Offset topLeft = (topLobeRect.topLeft * scale) + center;
    final Offset bottomRight = (topLobeRect.bottomRight * scale) + center;
    double shift = 0.0;
    if (topLeft.dx < edgeMargin) {
      shift = edgeMargin - topLeft.dx;
    }
    if (bottomRight.dx > parentBox.size.width - edgeMargin) {
      shift = parentBox.size.width - bottomRight.dx - edgeMargin;
    }
    shift = scale == 0.0 ? 0.0 : shift / scale;
    return shift;
  }

  void drawValueIndicator(
      RenderBox parentBox,
      Canvas canvas,
      Offset center,
      Paint paint,
      double scale,
      TextPainter labelPainter,
      Color strokePaintColor,
      ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    // The entire value indicator should scale with the size of the label,
    // to keep it large enough to encompass the label text.
    final double textScaleFactor = labelPainter.height / _labelTextDesignSize;
    final double overallScale = scale * textScaleFactor;
    canvas.scale(overallScale, overallScale);
    final double inverseTextScale = textScaleFactor != 0 ? 1.0 / textScaleFactor : 0.0;
    final double labelHalfWidth = labelPainter.width / 2.0;

    // This is the needed extra width for the label.  It is only positive when
    // the label exceeds the minimum size contained by the round top lobe.
    final double halfWidthNeeded = math.max(
      0.0,
      inverseTextScale * labelHalfWidth - (_topLobeRadius - _labelPadding),
    );

    double shift = _getIdealOffset(parentBox, halfWidthNeeded, overallScale, center);
    double leftWidthNeeded;
    double rightWidthNeeded;
    if (shift < 0.0) {
      // shifting to the left
      shift = math.max(shift, -halfWidthNeeded);
    } else {
      // shifting to the right
      shift = math.min(shift, halfWidthNeeded);
    }
    rightWidthNeeded = halfWidthNeeded + shift;
    leftWidthNeeded = halfWidthNeeded - shift;

    final Path path = Path();
    final Offset bottomLobeEnd = _addBottomLobe(path);

    // The base of the triangle between the top lobe center and the centers of
    // the two top neck arcs.
    final double neckTriangleBase = _topNeckRadius - bottomLobeEnd.dx;
    // The parameter that describes how far along the transition from round to
    // stretched we are.
    final double leftAmount = math.max(0.0, math.min(1.0, leftWidthNeeded / neckTriangleBase));
    final double rightAmount = math.max(0.0, math.min(1.0, rightWidthNeeded / neckTriangleBase));
    // The angle between the top neck arc's center and the top lobe's center
    // and vertical.
    final double leftTheta = (1.0 - leftAmount) * _thirtyDegrees;
    final double rightTheta = (1.0 - rightAmount) * _thirtyDegrees;
    // The center of the top left neck arc.
    final Offset neckLeftCenter = Offset(
      -neckTriangleBase,
      _topLobeCenter.dy + math.cos(leftTheta) * _neckTriangleHypotenuse,
    );
    final Offset neckRightCenter = Offset(
      neckTriangleBase,
      _topLobeCenter.dy + math.cos(rightTheta) * _neckTriangleHypotenuse,
    );
    final double leftNeckArcAngle = _ninetyDegrees - leftTheta;
    final double rightNeckArcAngle = math.pi + _ninetyDegrees - rightTheta;
    // The distance between the end of the bottom neck arc and the beginning of
    // the top neck arc. We use this to shrink/expand it based on the scale
    // factor of the value indicator.
    final double neckStretchBaseline = math.max(0.0, bottomLobeEnd.dy - math.max(neckLeftCenter.dy, neckRightCenter.dy));
    final double t = math.pow(inverseTextScale, 3.0);
    final double stretch = (neckStretchBaseline * t).clamp(0.0, 10.0 * neckStretchBaseline);
    final Offset neckStretch = Offset(0.0, neckStretchBaseline - stretch);

    assert(!_debuggingLabelLocation ||
            () {
          final Offset leftCenter = _topLobeCenter - Offset(leftWidthNeeded, 0.0) + neckStretch;
          final Offset rightCenter = _topLobeCenter + Offset(rightWidthNeeded, 0.0) + neckStretch;
          final Rect valueRect = Rect.fromLTRB(
            leftCenter.dx - _topLobeRadius,
            leftCenter.dy - _topLobeRadius,
            rightCenter.dx + _topLobeRadius,
            rightCenter.dy + _topLobeRadius,
          );
          final Paint outlinePaint = Paint()
            ..color = const Color(0xffff0000)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0;
          canvas.drawRect(valueRect, outlinePaint);
          return true;
        }());

    _addArc(
      path,
      neckLeftCenter + neckStretch,
      _topNeckRadius,
      0.0,
      -leftNeckArcAngle,
    );
    _addArc(
      path,
      _topLobeCenter - Offset(leftWidthNeeded, 0.0) + neckStretch,
      _topLobeRadius,
      _ninetyDegrees + leftTheta,
      _twoSeventyDegrees,
    );
    _addArc(
      path,
      _topLobeCenter + Offset(rightWidthNeeded, 0.0) + neckStretch,
      _topLobeRadius,
      _twoSeventyDegrees,
      _twoSeventyDegrees + math.pi - rightTheta,
    );
    _addArc(
      path,
      neckRightCenter + neckStretch,
      _topNeckRadius,
      rightNeckArcAngle,
      math.pi,
    );

    if (strokePaintColor != null) {
      final Paint strokePaint = Paint()
        ..color = strokePaintColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, strokePaint);
    }

    canvas.drawPath(path, paint);

    // Draw the label.
    canvas.save();
    canvas.translate(shift, -_distanceBetweenTopBottomCenters + neckStretch.dy);
    canvas.scale(inverseTextScale, inverseTextScale);
    labelPainter.paint(canvas, Offset.zero - Offset(labelHalfWidth, labelPainter.height / 2.0));
    canvas.restore();
    canvas.restore();
  }
}
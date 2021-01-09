import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliderPollTrackShape extends SliderTrackShape {
  final double average;

  const SliderPollTrackShape({this.average});

  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled,
    bool isDiscrete,
  }) {
    final thumbWidth =
        sliderTheme.thumbShape.getPreferredSize(true, isDiscrete).width;
    final trackHeight = sliderTheme.trackHeight;

    assert(thumbWidth >= 0.0);
    assert(trackHeight >= 0.0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);

    final trackLeft = offset.dx + thumbWidth / 2.0;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2.0;
    final trackWidth = parentBox.size.width - thumbWidth;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    @required RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    @required Animation<double> enableAnimation,
    @required TextDirection textDirection,
    @required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);

    if (sliderTheme.trackHeight <= 0.0) return;

    final activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final inactiveTrackColorTween = ColorTween(
      begin: sliderTheme.disabledInactiveTrackColor,
      end: sliderTheme.inactiveTrackColor,
    );
    final activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);

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

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final leftTrackArcRect = Rect.fromLTWH(
      trackRect.left,
      trackRect.top,
      trackRect.height,
      trackRect.height,
    );

    if (!leftTrackArcRect.isEmpty) {
      context.canvas.drawArc(
        leftTrackArcRect,
        math.pi / 2.0,
        math.pi,
        false,
        leftTrackPaint,
      );
    }

    final rightTrackArcRect = Rect.fromLTWH(
      trackRect.right - trackRect.height / 2.0,
      trackRect.top,
      trackRect.height,
      trackRect.height,
    );

    if (!rightTrackArcRect.isEmpty) {
      context.canvas.drawArc(
        rightTrackArcRect,
        -math.pi / 2.0,
        math.pi,
        false,
        rightTrackPaint,
      );
    }

    final thumbSize =
        sliderTheme.thumbShape.getPreferredSize(isEnabled, isDiscrete);
    final leftTrackSegment = Rect.fromLTRB(
      trackRect.left + trackRect.height / 2.0,
      trackRect.top,
      thumbCenter.dx - thumbSize.width / 2.0,
      trackRect.bottom,
    );

    if (!leftTrackSegment.isEmpty) {
      context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
    }

    final rightTrackSegment = Rect.fromLTRB(
      thumbCenter.dx + thumbSize.width / 2.0,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    if (!rightTrackSegment.isEmpty) {
      context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
    }

    if (average != null) {
      final offset = Offset(
        trackRect.left + average * (trackRect.right - trackRect.left) / 100.0,
        trackRect.top + trackRect.height / 2.0,
      );

      context.canvas.drawCircle(
        offset,
        6.0,
        Paint()..color = Colors.white,
      );
      context.canvas.drawCircle(
        offset,
        4.0,
        Paint()..color = Colors.orange[300],
      );
    }
  }
}

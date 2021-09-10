import 'package:flutter/material.dart';

class SliderPollThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;
  final bool voted;

  const SliderPollThumbCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
    this.voted = false,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  String _getMaxedValue(double value) => (max * value).round().toString();

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final paint = Paint()
      ..color = voted ? Colors.white : Colors.teal
      ..style = PaintingStyle.fill;

    final textSpan = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * 0.8,
        fontWeight: FontWeight.w700,
        color: voted ? Colors.orangeAccent : Colors.white,
      ),
      text: _getMaxedValue(value),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    final textCenter = Offset(
      center.dx - (textPainter.width / 2.0),
      center.dy - (textPainter.height / 2.0),
    );

    canvas.drawCircle(center, thumbRadius * 0.9, paint);
    textPainter.paint(canvas, textCenter);
  }
}

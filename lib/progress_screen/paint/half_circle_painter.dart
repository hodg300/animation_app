import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../utils/colors.dart';

class HalfCirclePainter extends CustomPainter {
  final double animationValue;
  final Color startColor;
  final Color endColor;
  final bool setBoxShadow;

  HalfCirclePainter(
      {required this.animationValue,
      required this.startColor,
      required this.endColor,
        this.setBoxShadow = false,})
      : super(repaint: ValueNotifier(animationValue));

  @override
  void paint(Canvas canvas, Size size) {


    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.height / 2;

    // Calculate the start and sweep angles for the half circle based on animation value
    const startAngle = math.pi / 2;
    final sweepAngle = -math.pi * animationValue;

    final paint = Paint()
      ..shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle - sweepAngle,
        transform: GradientRotation(sweepAngle),
        colors: [
          endColor,
          startColor
        ],
        tileMode: TileMode.mirror,
        // stops: []
      ).createShader(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: radius,
      ))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;


    if(setBoxShadow){
      // Add boxShadow
      const boxShadow = BoxShadow(
        color: Colors.grey,
        spreadRadius: 5.0,
        blurRadius: 7.0,
        offset: Offset(1.0, 0.0),
      );

      canvas.drawShadow(
        Path()
          ..moveTo(centerX - radius, centerY)
          ..arcTo(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius), startAngle, sweepAngle, true),
        boxShadow.color,
        boxShadow.blurRadius,
        true,
      );
    }


    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint);
  }

  @override
  bool shouldRepaint(HalfCirclePainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';

class CustomProgressPainter extends CustomPainter {
  final double progress; // Value between 0.0 and 1.0

  CustomProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;

    final double startAngle = -90 * (3.14 / 180); // Start from the top
    final double sweepAngle = 360 * progress * (3.14 / 180);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

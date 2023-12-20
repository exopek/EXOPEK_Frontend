import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurveHeader extends CustomPainter {
  final Color color;
  final ui.Image? image;

  CurveHeader({required this.image, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.45)
      /* ..quadraticBezierTo(size.width * 0.071, size.height * 0.3,
          size.width * 0.0, size.height * 0.5) */
      ..quadraticBezierTo(
          size.width * 0.04, size.height * 0.06, size.width, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    canvas.drawPath(path, paint);
    var offset = const Offset(0.0, 0.0);
    /* var image = Image.asset('assets/images/testImage.jpeg'); */

    if (image != null) {
      canvas.drawImage(image!, offset, paint);
    }
  }

  @override
  bool shouldRepaint(CurveHeader oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CurveHeader oldDelegate) => false;
}

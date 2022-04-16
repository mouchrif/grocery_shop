import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:grocery_shop/constants.dart';

class CustomPaintShape extends CustomPainter {
  final BuildContext context;
  const CustomPaintShape({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint mainPaint = Paint()
      ..color = kWhiteColor
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Paint middlePaint = Paint()
      ..color = Theme.of(context).primaryColor
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Paint lowerPaint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0,0), 
        Offset(size.width, size.height), 
        [
          Theme.of(context).primaryColor,
          kGreenLightColor,
        ],
      )
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Paint lastPaint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.9)
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path upperPath = Path();
    upperPath.moveTo(0, 0);
    upperPath.lineTo(0, size.height - 100);
    upperPath.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 100);
    upperPath.lineTo(size.width, 0);
    upperPath.close();

    Path middlePath = Path();
    middlePath.moveTo(0, 0);
    middlePath.lineTo(0, size.height - 70);
    middlePath.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 100);
    middlePath.lineTo(size.width, 0);
    middlePath.close();

    Path lowerPath = Path();
    lowerPath.moveTo(0, 0);
    lowerPath.lineTo(0, size.height - 10);
    lowerPath.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 75);
    lowerPath.lineTo(size.width, 0);
    lowerPath.close();

    Path lastPath = Path();
    lastPath.moveTo(0, 0);
    lastPath.lineTo(0, size.height / 2);
    lastPath.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    lastPath.lineTo(size.width, 0);
    lastPath.close();

    canvas.drawPath(lastPath, lastPaint);
    canvas.drawPath(lowerPath, lowerPaint);
    canvas.drawPath(middlePath, middlePaint);
    canvas.drawPath(upperPath, mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

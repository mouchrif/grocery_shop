import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double radius = 50.0;

    Path path = Path();
    path.lineTo(0, height - radius);
    path.quadraticBezierTo(width / 2, height, width, height - radius);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

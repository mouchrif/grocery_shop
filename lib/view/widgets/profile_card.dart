import 'package:flutter/material.dart';

class ProfileCard extends CustomPainter {
  final BuildContext context;
  const ProfileCard({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..color = Theme.of(context).primaryColor
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Paint wavePaint = Paint()
      ..color = Colors.green[900]!.withOpacity(0.1)
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path wavePath = Path();
    wavePath.moveTo(0, size.height);
    wavePath.cubicTo(size.width / 4, size.height / 4, size.width / 2,
        size.height / 2, size.width, 0);
    wavePath.lineTo(size.width, size.height);
    wavePath.close();

    // Paint circlePaint = Paint()
    //   ..color = Colors.red[900]!.withOpacity(0.1)
    //   ..strokeWidth = 1
    //   ..isAntiAlias = true
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.fill;
    // Offset circleOffset = Offset(size.width / 2, size.height / 2);
    // double radius = size.height * 0.4;

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), fillPaint);
    canvas.drawPath(wavePath, wavePaint);
    // canvas.drawCircle(circleOffset, radius, circlePaint);
  }

  @override
  bool shouldRepaint(ProfileCard oldDelegate) {
    return false;
  }
}

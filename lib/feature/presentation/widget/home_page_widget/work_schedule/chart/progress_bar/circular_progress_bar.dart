import 'dart:math';
import 'package:flutter/material.dart';

class CircularProgressBar extends CustomPainter {
  final int acrpInspectionStatusCount;
  final int acrpAssetIdCount;

  CircularProgressBar({
    required this.acrpInspectionStatusCount,
    required this.acrpAssetIdCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..color = Colors.black
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 70;
    canvas.drawCircle(center, radius, circle);

    Paint animationArc = Paint()
      ..strokeWidth = 15
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double angle = 2 * pi * (acrpInspectionStatusCount / acrpAssetIdCount);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        angle, false, animationArc);

    // Display the values inside the circle
    TextPainter tp1 = TextPainter(
      text: const TextSpan(
        //text: acrpInspectionStatusCount.toString(),
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );
    tp1.layout();
    tp1.paint(
        canvas, Offset(center.dx - tp1.width / 2, center.dy - tp1.height / 2));

    TextPainter tp2 = TextPainter(
      text: const TextSpan(
        // text: acrpAssetIdCount.toString(),
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );
    tp2.layout();
    tp2.paint(
        canvas, Offset(center.dx - tp2.width / 2, center.dy + tp1.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

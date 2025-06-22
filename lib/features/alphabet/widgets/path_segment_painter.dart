import 'package:flutter/material.dart';

class PathSegmentPainter extends CustomPainter {
  final bool fromLeft;
  final bool toLeft;
  final double itemHeight;

  PathSegmentPainter({
    required this.fromLeft,
    required this.toLeft,
    required this.itemHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double startX = fromLeft ? 40 : size.width - 40;
    double startY = size.height - (itemHeight / 2);

    double endX = toLeft ? 40 : size.width - 40;
    double endY = size.height - (itemHeight + itemHeight / 2);

    double controlX = size.width / 2;
    double controlY = startY - (itemHeight / 2);

    final path = Path();
    path.moveTo(startX, startY);
    path.quadraticBezierTo(controlX, controlY, endX, endY);

    drawDashedLine(canvas, path, paint);
  }

  void drawDashedLine(Canvas canvas, Path path, Paint paint) {
    for (final metric in path.computeMetrics()) {
      double dashLength = 12;
      double gapLength = 8;
      double distance = 0;

      while (distance < metric.length) {
        final next = distance + dashLength;
        final subPath = metric.extractPath(distance, next.clamp(0, metric.length));
        canvas.drawPath(subPath, paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

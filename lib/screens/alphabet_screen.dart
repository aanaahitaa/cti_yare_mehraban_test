import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class AlphabetPage extends StatelessWidget {
  final List<String> letters = [
    'آ', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح', 'خ', 'د',
    'ذ', 'ر', 'ز', 'ژ', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ',
    'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ه', 'ی'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('آموزش الفبا', style: AppStyles.appBarTextStyle),
        backgroundColor: AppColors.backgroundStart,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double itemHeight = 100; // ارتفاع هر دکمه
          double totalHeight = letters.length * itemHeight;

          return SingleChildScrollView(
            reverse: true, // شروع از پایین
            child: SizedBox(
              height: totalHeight,
              child: Stack(
                children: [
                  // مسیر مارپیچ که همراه دکمه‌ها حرکت می‌کند
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PathPainter(letters.length, itemHeight),
                    ),
                  ),
                  // لیست دکمه‌های الفبا
                  ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(), // اسکرول را به SingleChildScrollView بسپار
                    itemCount: letters.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: index.isEven ? Alignment.centerLeft : Alignment.centerRight,
                        child: LetterButton(text: letters[index], isActive: index == 0),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LetterButton extends StatelessWidget {
  final String text;
  final bool isActive;

  const LetterButton({required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.disabled.withOpacity(0.5),
        shape: BoxShape.circle,
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: AppColors.primary.withOpacity(0.7),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final int itemCount;
  final double itemHeight;

  PathPainter(this.itemCount, this.itemHeight);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.shade500.withOpacity(0.5) // رنگ خاکستری خط‌چین
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    double startY = size.height - itemHeight / 1.2; // شروع از پایین

    path.moveTo(size.width * 0.2, startY);

    for (int i = 0; i < itemCount; i++) {
      double controlX = i.isEven ? size.width * 1.32 : size.width * -0.2;
      double controlY = startY - (i + 0.5) * itemHeight;
      double endX = size.width * 0.5;
      double endY = startY - ((i + 1) * itemHeight) + (itemHeight / 50);

      path.quadraticBezierTo(controlX, controlY, endX, endY);
    }

    drawDashedLine(canvas, path, paint);
  }

  void drawDashedLine(Canvas canvas, Path path, Paint paint) {
    PathMetric pathMetric = path.computeMetrics().first;
    double dashLength = 10.0;
    double gapLength = 10.0;
    double distance = 0.0;

    while (distance < pathMetric.length) {
      double nextDistance = distance + dashLength;
      if (nextDistance > pathMetric.length) nextDistance = pathMetric.length;

      canvas.drawPath(
        pathMetric.extractPath(distance, nextDistance),
        paint,
      );
      distance += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

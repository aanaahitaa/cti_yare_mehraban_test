import 'package:flutter/material.dart';
import 'letter_screen.dart';
import '../services/progress_service.dart';
import '../theme/app_styles.dart';

class AlphabetPage extends StatelessWidget {
  final List<String> letters = const [
    'آ', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح', 'خ', 'د',
    'ذ', 'ر', 'ز', 'ژ', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ',
    'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ه', 'ی'
  ];

  const AlphabetPage({super.key});

  @override
  Widget build(BuildContext context) {
    double itemHeight = 110;

    return Scaffold(
      appBar: AppBar(
        title: Text('آموزش الفبا', style: AppStyles.appBarTextStyle),
        backgroundColor: AppColors.backgroundStart,
      ),
      body: FutureBuilder<int>(
        future: ProgressService.getLearnedCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("خطا در بارگذاری اطلاعات"));
          }

          int learnedCount = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: LinearProgressIndicator(
                  value: learnedCount / letters.length,
                  backgroundColor: Colors.white24,
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: letters.length,
                  itemExtent: itemHeight,
                  itemBuilder: (context, index) {
                    bool isActive = index <= learnedCount;

                    return Stack(
                      children: [
                        if (index < letters.length - 1)
                          CustomPaint(
                            painter: PathSegmentPainter(
                              fromLeft: index.isEven,
                              toLeft: (index + 1).isEven,
                              itemHeight: itemHeight,
                            ),
                            size: Size.infinite,
                          ),
                        Align(
                          alignment: index.isEven
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: LetterButton(
                            text: letters[index],
                            isActive: isActive,
                            onPressed: isActive
                                ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LetterDetailPage(
                                    letter: letters[index],
                                    index: index,
                                  ),
                                ),
                              );
                            }
                                : null,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LetterButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onPressed;

  const LetterButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.primaryDisabled,
          shape: BoxShape.circle,
          boxShadow: isActive
              ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Center(
          child: isActive
              ? Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
              : Stack(
            alignment: Alignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.lock,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'letter_game_page.dart';

class LetterDetailPage extends StatefulWidget {
  final String letter;
  final int index;

  const LetterDetailPage({
    super.key,
    required this.letter,
    required this.index,
  });

  @override
  State<LetterDetailPage> createState() => _LetterDetailPageState();
}

class _LetterDetailPageState extends State<LetterDetailPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isDrawn = false;
  late List<Offset?> drawnPoints;

  final Map<String, String> letterToFileName = {
    'ا': 'a.mp3',
    'آ': 'aa.mp3',
    'ب': 'b.mp3',
    'پ': 'p.mp3',
    'ت': 't.mp3',
    'ث': 'th.mp3',
    'ج': 'j.mp3',
    'چ': 'ch.mp3',
    'ح': 'h.mp3',
    'خ': 'kh.mp3',
    'د': 'd.mp3',
    'ذ': 'z.mp3',
    'ر': 'r.mp3',
    'ز': 'z2.mp3',
    'ژ': 'zh.mp3',
    'س': 's.mp3',
    'ش': 'sh.mp3',
    'ص': 's2.mp3',
    'ض': 'z3.mp3',
    'ط': 't2.mp3',
    'ظ': 'z4.mp3',
    'ع': 'a2.mp3',
    'غ': 'gh.mp3',
    'ف': 'f.mp3',
    'ق': 'gh2.mp3',
    'ک': 'k.mp3',
    'گ': 'g.mp3',
    'ل': 'l.mp3',
    'م': 'm.mp3',
    'ن': 'n.mp3',
    'و': 'v.mp3',
    'ه': 'h2.mp3',
    'ی': 'y.mp3',
  };

  @override
  void initState() {
    super.initState();
    drawnPoints = [];
    playLetterSound();
  }

  Future<void> playLetterSound() async {
    final fileName = letterToFileName[widget.letter];
    if (fileName == null) {
      debugPrint('No audio file for: ${widget.letter}');
      return;
    }

    try {
      await _audioPlayer.play(AssetSource('sounds/letters/$fileName'));
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('خطا در پخش صدا')),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void goToGamePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LetterGamePage(
          letter: widget.letter,
          index: widget.index,
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      drawnPoints.add(details.localPosition);
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      drawnPoints.add(null);
      isDrawn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      appBar: buildAppBar(context, 'حرف ${widget.letter}'),
      body: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.volume_up_rounded, size: 36, color: AppColors.primary),
              onPressed: playLetterSound,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.letter,
                    style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'با انگشتت این حرف رو بکش',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.2,
                        ),
                      ),
                      child: GestureDetector(
                        onPanUpdate: onPanUpdate,
                        onPanEnd: onPanEnd,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CustomPaint(
                            size: const Size(double.infinity, 300), // ارتفاع قابل تنظیم
                            painter: LetterPainter(drawnPoints),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (isDrawn)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonMainColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                        textStyle: AppStyles.customButtonTextStyle,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 6,
                      ),
                      onPressed: goToGamePage,
                      icon: const Icon(Icons.play_arrow_rounded, size: 28),
                      label: const Text('مرحله بعد'),
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LetterPainter extends CustomPainter {
  final List<Offset?> points;

  LetterPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {

    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final paint = Paint()
      ..color = AppColors.primary
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
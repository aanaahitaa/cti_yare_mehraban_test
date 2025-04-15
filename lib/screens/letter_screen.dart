import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'letter_game_page.dart';
import '../theme/app_styles.dart';

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
  late List<Offset?> points;

  @override
  void initState() {
    super.initState();
    playLetterSound();
    points = [];
  }

  Future<void> playLetterSound() async {
    await _audioPlayer.play(AssetSource('sounds/${widget.letter}.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void proceedToGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LetterGamePage(
          letter: widget.letter,
          index: widget.index,
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      points.add(details.localPosition);
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      isDrawn = true; // اگر کشیدن تمام شد، دکمه فعال بشه
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حرف ${widget.letter}', style: AppStyles.appBarTextStyle),
        backgroundColor: AppColors.backgroundStart,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.letter,
              style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'حالا با انگشتت این حرف رو بکش!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onPanUpdate: onPanUpdate,
              onPanEnd: onPanEnd,
              child: CustomPaint(
                size: Size(300, 300),
                painter: LetterPainter(points),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                proceedToGame();
              },
              child: const Text('کشیدم! بریم مرحله بعد'),
            ),
            const SizedBox(height: 20),
            if (isDrawn)
              ElevatedButton.icon(
                onPressed: proceedToGame,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('شروع بازی'),
              ),
          ],
        ),
      ),
    );
  }
}

class LetterPainter extends CustomPainter {
  final List<Offset?> points;

  LetterPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

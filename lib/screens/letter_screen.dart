import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'letter_game_page.dart';
import '../theme/app_styles.dart';

class LetterDetailPage extends StatefulWidget {
  final String letter;
  final int index; // برای مشخص کردن جایگاه حرف

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

  @override
  void initState() {
    super.initState();
    playLetterSound();
  }

  Future<void> playLetterSound() async {
    // TODO: Sohaila - فرض: صداها داخل assets/sounds/ با نام حرف هستند، مثلاً آ → sounds/alef.mp3
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
        builder: (_) => LetterGamePage(
          letter: widget.letter,
          index: widget.index,
        ),
      ),
    );
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
            ElevatedButton(
              onPressed: () {
                setState(() => isDrawn = true);
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

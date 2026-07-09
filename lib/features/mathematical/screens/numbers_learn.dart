import 'package:audioplayers/audioplayers.dart';
import 'package:cti_yare_mehraban_test/features/mathematical/models/numbers_item.dart';
import 'package:cti_yare_mehraban_test/features/mathematical/screens/numbers_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';

class NumbersLearn extends StatefulWidget {
  const NumbersLearn({super.key});

  @override
  State<NumbersLearn> createState() => _NumbersLearnState();
}

class _NumbersLearnState extends State<NumbersLearn> {
  final AudioPlayer player = AudioPlayer();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  void playAudio() {
    final audioFile = 'sounds/numbers/${numberWords[currentIndex]['key']}.mp3';
    player.play(AssetSource(audioFile));
  }

  void goNext() {
    if (currentIndex < numberWords.length - 1) {
      setState(() {
        currentIndex++;
      });
      playAudio();
    } else {
      showEndDialog();
    }
  }

  void goPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      playAudio();
    }
  }

  void showEndDialog() {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('آموزش تمام شد'),
          content: const Text(
            'می‌خواهی دوباره آموزش را شروع کنی یا برگردی به منو؟',
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => currentIndex = 0);
                Navigator.pop(context);
                playAudio();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('دوباره', style: TextStyle(color: AppColors.primary)),
                  SizedBox(width: 10),
                  Icon(Icons.refresh, color: AppColors.primary),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumbersLearningScreen(),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('بازگشت', style: TextStyle(color: AppColors.primary)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_circle_left, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = numberWords[currentIndex];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, 'آموزش کلمات'),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.volume_up_rounded,
                        size: 32,
                        color: AppColors.primary,
                      ),
                      onPressed: playAudio,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  word['value']!,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontFamily: 'IRANSansDN',
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 500,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: AppColors.primaryDisabled,
                      child: Image.asset(
                        'assets/images/numbers/${word['key']}.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                    ),
                    onPressed: goPrevious,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('قبلی'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: goNext,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('بعدی'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cti_yare_mehraban_test/features/mathematical/models/numbers_item.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';

class NumbersQuizScreen extends StatefulWidget {
  const NumbersQuizScreen({super.key});

  @override
  State<NumbersQuizScreen> createState() => _NumbersQuizScreenState();
}

class _NumbersQuizScreenState extends State<NumbersQuizScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late int currentIndex;
  bool hasAnsweredCorrectly = false;
  String? selectedOption;
  bool showWrongMessage = false;
  bool showNextButton = false;

  List<String> options = [];

  @override
  void initState() {
    super.initState();
    currentIndex = Random().nextInt(numberWords.length);
    generateOptions();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void generateOptions() {
    final correct = numberWords[currentIndex]['value']!;
    final tempOptions = <String>[correct];

    for (final item in numberWords) {
      if (tempOptions.length >= 4) break;
      if (item['value'] != correct) {
        tempOptions.add(item['value']!);
      }
    }

    tempOptions.shuffle();
    options = tempOptions;
  }

  void checkAnswer(String answer) async {
    if (hasAnsweredCorrectly) return;

    final correct = numberWords[currentIndex]['value']!;
    if (answer == correct) {
      setState(() {
        selectedOption = answer;
        hasAnsweredCorrectly = true;
        showWrongMessage = false;
      });

      await _audioPlayer.play(
        AssetSource('sounds/numbers/${numberWords[currentIndex]['key']}.mp3'),
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            showNextButton = true;
          });
        }
      });
    } else {
      setState(() {
        selectedOption = answer;
        showWrongMessage = true;
        showNextButton = false;
      });
    }
  }

  void goNext() {
    if (currentIndex < numberWords.length - 1) {
      setState(() {
        currentIndex++;
        hasAnsweredCorrectly = false;
        selectedOption = null;
        showWrongMessage = false;
        showNextButton = false;
      });
      generateOptions();
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 پایان بازی'),
          content: const Text('آفرین! همه‌ی نمبرها را شناختی.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentIndex = Random().nextInt(numberWords.length);
                  hasAnsweredCorrectly = false;
                  selectedOption = null;
                  showWrongMessage = false;
                  showNextButton = false;
                });
                generateOptions();
              },
              child: Text('شروع دوباره'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('بستن'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final word = numberWords[currentIndex];
    final correctAnswer = word['value']!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, 'کوئیز '),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/numbers/${word['key']}.jpeg',
                    width: 250,
                    height: 250,
                  ),
                ),
                const SizedBox(height: 24),

                ...options.map((option) {
                  bool isCorrectOption = option == correctAnswer;
                  bool isSelected = option == selectedOption;

                  Color backgroundColor = AppColors.buttonMainShadowColor
                      .withOpacity(0.6);

                  if (hasAnsweredCorrectly && isCorrectOption) {
                    backgroundColor = Colors.green.shade400;
                  } else if (!hasAnsweredCorrectly &&
                      isSelected &&
                      !isCorrectOption) {
                    backgroundColor = Colors.red.shade400;
                  }

                  return Container(
                    width: 250,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (!hasAnsweredCorrectly) {
                          checkAnswer(option);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 70,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.buttonMainShadowColor
                                  .withOpacity(0.6),
                              offset: const Offset(3, 3),
                              blurRadius: 6,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          border: hasAnsweredCorrectly && isCorrectOption
                              ? Border.all(color: Colors.green, width: 3)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'IRANSansDN',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                if (showWrongMessage)
                  Text(
                    'اشتباه بود! دوباره امتحان کن ❌',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IRANSansDN',
                    ),
                  )
                else if (hasAnsweredCorrectly && showNextButton)
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'آفرین! درست بود ✅',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IRANSansDN',
                          ),
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../services/alphabet_service.dart';
import 'letter_screen.dart';

class LetterGamePage extends StatefulWidget {
  final String letter;
  final int index;

  const LetterGamePage({super.key, required this.letter, required this.index});

  @override
  State<LetterGamePage> createState() => _LetterGamePageState();
}

class _LetterGamePageState extends State<LetterGamePage> {
  bool gameCompleted = false;
  bool isCorrectChosen = false;
  bool hasAttempted = false;
  List<String> choices = [];

  @override
  void initState() {
    super.initState();
    generateChoices();
  }

  void generateChoices() {
    const allLetters = [
      'آ',
      'ب',
      'پ',
      'ت',
      'ث',
      'ج',
      'چ',
      'ح',
      'خ',
      'د',
      'ذ',
      'ر',
      'ز',
      'ژ',
      'س',
      'ش',
      'ص',
      'ض',
      'ط',
      'ظ',
      'ع',
      'غ',
      'ف',
      'ق',
      'ک',
      'گ',
      'ل',
      'م',
      'ن',
      'و',
      'ه',
      'ی',
    ];

    final random = Random();
    Set<String> randomLetters = {};

    while (randomLetters.length < 5) {
      String randLetter = allLetters[random.nextInt(allLetters.length)];
      if (randLetter != widget.letter) {
        randomLetters.add(randLetter);
      }
    }

    randomLetters.add(widget.letter);
    choices = randomLetters.toList()..shuffle();
  }

  String getNextLetter() {
    const allLetters = [
      'آ',
      'ب',
      'پ',
      'ت',
      'ث',
      'ج',
      'چ',
      'ح',
      'خ',
      'د',
      'ذ',
      'ر',
      'ز',
      'ژ',
      'س',
      'ش',
      'ص',
      'ض',
      'ط',
      'ظ',
      'ع',
      'غ',
      'ف',
      'ق',
      'ک',
      'گ',
      'ل',
      'م',
      'ن',
      'و',
      'ه',
      'ی',
    ];

    int currentIndex = allLetters.indexOf(widget.letter);
    return currentIndex < allLetters.length - 1
        ? allLetters[currentIndex + 1]
        : allLetters[0];
  }

  void showEndDialog() {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('🎉 آفرین!'),
          content: const Text('تمام حروف را یاد گرفتی.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LetterDetailPage(letter: 'آ', index: 0),
                  ),
                );
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
              onPressed: () {
                Navigator.pop(context);
              },
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

  void handleChoice(String selectedLetter) async {
    bool isCorrect = selectedLetter == widget.letter;

    setState(() {
      hasAttempted = true;
      isCorrectChosen = isCorrect;
      if (isCorrect) gameCompleted = true;
    });

    if (isCorrect) {
      await ProgressService.updateLearnedCount(widget.index);
      await Future.delayed(const Duration(seconds: 2));

      const allLetters = [
        'آ',
        'ب',
        'پ',
        'ت',
        'ث',
        'ج',
        'چ',
        'ح',
        'خ',
        'د',
        'ذ',
        'ر',
        'ز',
        'ژ',
        'س',
        'ش',
        'ص',
        'ض',
        'ط',
        'ظ',
        'ع',
        'غ',
        'ف',
        'ق',
        'ک',
        'گ',
        'ل',
        'م',
        'ن',
        'و',
        'ه',
        'ی',
      ];

      if (widget.index < allLetters.length - 1) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LetterDetailPage(
                letter: getNextLetter(),
                index: widget.index + 1,
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          showEndDialog();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundEnd,
        appBar: buildAppBar(context, 'بازی حرف ${widget.letter}'),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'روی حرف "${widget.letter}" کلیک کن',
                  style: AppStyles.customButtonTextStyle.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: choices.map((letter) {
                    final bool isCorrect = letter == widget.letter;
                    final bool isChosen =
                        hasAttempted &&
                        isCorrectChosen &&
                        letter == widget.letter;

                    return GestureDetector(
                      onTap: () {
                        if (!gameCompleted) handleChoice(letter);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: gameCompleted && isCorrect
                              ? Colors.green.shade300
                              : AppColors.buttonMainColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.buttonMainShadowColor
                                  .withOpacity(0.6),
                              offset: const Offset(3, 3),
                              blurRadius: 6,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          border: isChosen
                              ? Border.all(color: Colors.green, width: 3)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: AppStyles.customButtonTextStyle,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                if (hasAttempted)
                  Text(
                    isCorrectChosen
                        ? 'آفرین! درست بود ✅'
                        : 'اشتباه بود! دوباره امتحان کن ❌',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'IRANSansDN',
                      color: isCorrectChosen ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
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

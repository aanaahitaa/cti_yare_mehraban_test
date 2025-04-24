import 'dart:math';
import 'package:flutter/material.dart';
import '../services/progress_service.dart';
import '../theme/app_styles.dart';
import '../widgets/custom_app_bar.dart';
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
      'آ', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'ژ',
      'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م',
      'ن', 'و', 'ه', 'ی'
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
      'آ', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'ژ',
      'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م',
      'ن', 'و', 'ه', 'ی'
    ];

    int currentIndex = allLetters.indexOf(widget.letter);
    return currentIndex < allLetters.length - 1 ? allLetters[currentIndex + 1] : allLetters[0];
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return GestureDetector(
                    onTap: () {
                      if (!gameCompleted) handleChoice(letter);
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.buttonMainColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.buttonMainShadowColor
                                .withOpacity(0.6),
                            offset: const Offset(3, 3),
                            blurRadius: 6,
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
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
                      ? 'آفرین! درست بود 👏'
                      : 'اشتباه بود، دوباره امتحان کن 😅',
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
    );
  }
}

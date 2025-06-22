import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../colors/models/color_item.dart';

class ColorsQuizScreen extends StatefulWidget {
  const ColorsQuizScreen({super.key});

  @override
  State<ColorsQuizScreen> createState() => _ColorsQuizScreenState();
}

class _ColorsQuizScreenState extends State<ColorsQuizScreen> {
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
    currentIndex = Random().nextInt(colorWords.length);
    generateOptions();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void generateOptions() {
    final correct = colorWords[currentIndex]['value']!;
    final tempOptions = <String>[correct];

    for (final item in colorWords) {
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

    final correct = colorWords[currentIndex]['value']!;
    if (answer == correct) {
      setState(() {
        selectedOption = answer;
        hasAnsweredCorrectly = true;
        showWrongMessage = false;
      });

      await _audioPlayer.play(
          AssetSource('sounds/colors/${colorWords[currentIndex]['key']}.mp3'));

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
    if (currentIndex < colorWords.length - 1) {
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
          content: const Text('آفرین! همه رنگ‌ها را شناختی.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentIndex = Random().nextInt(colorWords.length);
                  hasAnsweredCorrectly = false;
                  selectedOption = null;
                  showWrongMessage = false;
                  showNextButton = false;
                });
                generateOptions();
              },
              child: const Text('شروع دوباره'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('بستن'),
            ),
          ],
        ),
      );
    }
  }

  Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = colorWords[currentIndex];
    final correctAnswer = currentItem['value']!;

    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      appBar: buildAppBar(context, 'کوئیز رنگ'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: hexToColor(currentItem['color']!),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black54, width: 2),
                ),
              ),
              const SizedBox(height: 24),
              ...options.map((option) {
                bool isCorrectOption = option == correctAnswer;
                bool isSelected = option == selectedOption;

                Color backgroundColor =
                    AppColors.buttonMainShadowColor.withOpacity(0.6);

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
              }).toList(),
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
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_button.dart';
import 'images_game_screen.dart';
import 'images_learn.dart';
import 'images_quiz_screen.dart';

class ImagesLearningScreen extends StatelessWidget {
  const ImagesLearningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text('آموزش تصاویر', style: AppStyles.appBarTextStyle),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'تصاویر',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'IRANSansDN',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

            CustomButton(
              text: '📚 آموزش',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImagesLearnScreen(),
                  ),
                );
              },
            ),
              const SizedBox(height: 16),

              CustomButton(
                text: '📝 کوییز',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImagesQuizScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              CustomButton(
                text: '🎮 بازی',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemoryGameScreen(levelIndex: 0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

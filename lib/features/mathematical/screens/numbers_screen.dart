import 'package:cti_yare_mehraban_test/features/mathematical/screens/numbers_game_screen.dart';
import 'package:cti_yare_mehraban_test/features/mathematical/screens/numbers_learn.dart';
import 'package:cti_yare_mehraban_test/features/mathematical/screens/numbers_quiz_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_button.dart';

class NumbersLearningScreen extends StatelessWidget {
  const NumbersLearningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: Text('آموزش اعداد', style: AppStyles.appBarTextStyle),
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
                  'اعداد',
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
                      MaterialPageRoute(builder: (context) => NumbersLearn()),
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
                        builder: (context) => NumbersQuizScreen(),
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
                        builder: (context) => NumbersGameScreen(levelIndex: 0),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

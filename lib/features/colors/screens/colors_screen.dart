import 'package:flutter/material.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/widgets/custom_button.dart';
import 'colors_learn.dart';
import 'colors_quiz_screen.dart';

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text('آموزش رنگ‌ها', style: AppStyles.appBarTextStyle),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'رنگ‌ها',
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
                    MaterialPageRoute(builder: (context) => const ColorsLearnScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),

              CustomButton(
                text: '📝 کوئیز',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ColorsQuizScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}

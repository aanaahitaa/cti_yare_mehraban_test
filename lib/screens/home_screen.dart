import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../theme/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(text: 'حروف الفبا', onPressed: () {}),
              const SizedBox(height: 20),
              CustomButton(text: 'رنگ‌ها', onPressed: () {}),
              const SizedBox(height: 20),
              CustomButton(text: 'تصاویر', onPressed: () {}),
              const SizedBox(height: 20),
              CustomButton(
                text: 'ریاضی',
                onPressed: () {},
                isDisabled: true, // Disabled button
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'داستان‌ها',
                onPressed: () {},
                isDisabled: true, // Disabled button
              ),
            ],
          ),
        ),
      ),
    );
  }
}

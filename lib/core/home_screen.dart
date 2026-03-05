import 'package:cti_yare_mehraban_test/core/widgets/custom_button.dart';
import 'package:cti_yare_mehraban_test/features/mathematical/screens/numbers_screen.dart';
import 'package:flutter/material.dart';

// import 'package:koodak_app/features/colors/screens/colors_screen.dart';
// import 'package:koodak_app/features/images/screens/images_screen.dart';

import '../features/alphabet/screens/alphabet_screen.dart';
import '../features/colors/screens/colors_screen.dart' show ColorsScreen;
import '../features/images/screens/images_screen.dart';
import 'constants/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: '🔡 حروف الفبا',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AlphabetScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: '🌈 رنگ‌ها',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ColorsScreen()),
                  );
                },
              ),

              const SizedBox(height: 16),
              CustomButton(
                text: '🖼️ تصاویر',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagesLearningScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: '🔢 ریاضی',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NumbersLearningScreen(),
                    ),
                  );
                }, //
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: '📖 داستان‌ها',
                onPressed: () {}, // غیرفعال
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

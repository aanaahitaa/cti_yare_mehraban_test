import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFA01321);
  static const Color disabled = Color(0xFFA01321);
  static const Color backgroundStart = Color(0xFF526B33);
  static const Color backgroundEnd = Color(0xFFE5E3B1);

  static const Color textOnPrimary = Colors.white;
  static const Color textOnDark = Colors.white;
  static const Color textOnLight = Colors.black;
  static final Color textOnDisabled = textOnPrimary.withValues(alpha: 128);

  // New custom button colors
  static const Color buttonShadowColor = Color(0xFFFFDE6C);
  static const Color buttonShadowBoxColor = Color(0xFFFFD540);
  static const Color buttonMainColor = Color(0xFFFFCF25);
  static const Color buttonMainShadowColor = Color(0xFFECB800);
}

class AppStyles {
  // Existing button styles (for other parts if needed)
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20),
    minimumSize: const Size(348, 70),
  );

  static final ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.disabled.withValues(alpha: 128),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20),
    minimumSize: const Size(348, 70),
  );

  static final TextStyle buttonTextStyle = TextStyle(
    color: AppColors.textOnPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'IRANSansDN',
  );

  static final TextStyle disabledButtonTextStyle = TextStyle(
    color: AppColors.textOnDisabled,
    fontSize: 26,
    fontWeight: FontWeight.bold,
    fontFamily: 'IRANSansDN',
  );

  // New custom button text style for home page
  static final TextStyle customButtonTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    fontFamily: 'IRANSansDN',
  );

  static final TextStyle appBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'IRANSansDN',
  );
}

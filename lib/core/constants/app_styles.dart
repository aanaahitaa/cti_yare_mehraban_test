import 'package:flutter/material.dart';

class AppColors {
  // Primary background and theming
  static const Color primary = Color(0xFF2E473B);
  static const Color primaryDisabled = Color(0xFF9EABA6);
  static const Color accent = Color(0xFFFFD447);

  static const Color accentSoft = Color(0xFFFFB84D);

  // Text colors
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnLight = Color(0xFF333333);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // States
  static const Color success = Color(0xFF4DD0E1);
  static const Color error = Color(0xFFF48FB1);
  static const Color disabled = Color(0xFFBDBDBD);

  // Shadows and highlights
  static const Color shadow = Color(0x33000000);

  static const Color backgroundStart = Color(0xFF2E473B);
  static const Color backgroundEnd = Color(0xFFE5E3B1);

  static const Color buttonShadowColor = Color(0xFFFFDE6C);
  static const Color buttonShadowBoxColor = Color(0xFFFFD540);
  static const Color buttonMainColor = Color(0xFFFFCF25);
  static const Color buttonMainShadowColor = Color(0xFFECB800);
}



class AppStyles {
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20),
    minimumSize: const Size(348, 70),
  );

  static final ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryDisabled,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.symmetric(vertical: 20),
    minimumSize: const Size(348, 70),
  );

  static final TextStyle buttonTextStyle = TextStyle(
    color: AppColors.textOnDark,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'IRANSansDN',
  );

  static final TextStyle disabledButtonTextStyle = TextStyle(
    color: AppColors.textDisabled,
    fontSize: 26,
    fontWeight: FontWeight.bold,
    fontFamily: 'IRANSansDN',
  );

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

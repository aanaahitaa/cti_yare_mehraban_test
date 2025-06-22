import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.isActive = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Set opacity to 1.0 when active, or 0.5 when inactive
    final double opacity = isActive ? 1.0 : 0.5;

    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Opacity(
        opacity: opacity,
        child: SizedBox(
          width: 318,
          height: 87,
          child: Stack(
            children: [
              // Shadow Layer
              Positioned(
                left: 0.16,
                top: 0.61,
                child: Container(
                  width: 318,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: AppColors.buttonShadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: AppColors.buttonShadowBoxColor,
                        blurRadius: 0,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              // Main Button Layer
              Positioned(
                left: 4.17,
                top: 4.61,
                child: Container(
                  width: 310,
                  height: 68,
                  decoration: ShapeDecoration(
                    color: AppColors.buttonMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: AppColors.buttonMainShadowColor,
                        blurRadius: 0,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              // Button Text
              Positioned.fill(
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppStyles.customButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

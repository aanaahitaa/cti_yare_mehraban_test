import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';

class LetterButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onPressed;

  const LetterButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.primaryDisabled,
          shape: BoxShape.circle,
          boxShadow: isActive
              ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Center(
          child: isActive
              ? Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
              : Stack(
            alignment: Alignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.lock,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

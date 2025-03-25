import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348, // Ensure fixed width
      height: 70,  // Ensure fixed height
      child: ElevatedButton(
        style: isDisabled ? AppStyles.disabledButtonStyle : AppStyles.buttonStyle,
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          text,
          style: isDisabled ? AppStyles.disabledButtonTextStyle : AppStyles.buttonTextStyle,
        ),
      ),
    );
  }
}

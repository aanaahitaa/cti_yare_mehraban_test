import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../theme/app_styles.dart';


AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: AppStyles.appBarTextStyle),
    backgroundColor: AppColors.backgroundStart,
    actions: [
      IconButton(
        icon: Image.asset('assets/images/icon_home.webp', width: 40, height: 40),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
          );
        },
      ),
    ],
  );
}


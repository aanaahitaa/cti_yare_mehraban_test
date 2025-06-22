import 'package:flutter/material.dart';

import '../constants/app_styles.dart';
import '../home_screen.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: AppStyles.appBarTextStyle),
    backgroundColor: AppColors.backgroundStart,
    actions: [
      IconButton(
        icon: Icon(Icons.home_rounded, size: 28, color: Colors.white),
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

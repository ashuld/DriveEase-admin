import 'package:drive_ease_admin/view/core/colors.dart';
import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

SizedBox networkError() {
  return SizedBox(
    child: Column(
      children: [
        LottieBuilder.asset(height: 50.h, 'assets/lottie/network_lottie.json'),
        Text(
          'You have been disconnected from the Internet.\nPlease check Your Internet connection',
          style: textStyle(color: Colors.amberAccent),
        ),
      ],
    ),
  );
}

Future networkDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'No Internet Connection',
          style: textStyle(color: AppColors.secondaryColor),
        ),
        content: Text(
          'Please check your internet connection and try again.',
          style: textStyle(color: AppColors.secondaryColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

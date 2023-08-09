import 'package:drive_ease_admin/view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeGestureButton extends StatelessWidget {
  final String option;
  final String image;
  final VoidCallback onTapCallback;
  const HomeGestureButton(
      {super.key,
      required this.option,
      required this.onTapCallback,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade700, // Greyish color
          borderRadius: BorderRadius.circular(20), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800, // Shadow color
              offset: const Offset(0, 4), // Offset in X and Y direction
              blurRadius: 6, // Spread of the shadow
              spreadRadius: 2, // Size of the shadow
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image, height: 50),
              Text(option,
                  textAlign: TextAlign.center,
                  style: textStyle(size: 18, thickness: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

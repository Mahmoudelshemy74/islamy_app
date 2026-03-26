import 'package:flutter/material.dart';
import 'package:islamy_app/theme/colors.dart';

class BaseTabWidget extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final bool showGradient;

  const BaseTabWidget({
    super.key,
    required this.imagePath,
    required this.child,
    this.showGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        if (showGradient)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.black.withAlpha(180), AppColors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        child,
      ],
    );
  }
}

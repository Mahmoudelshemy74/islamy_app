import 'package:flutter/material.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';

// ignore: must_be_immutable
class OnboardingScreenModel extends StatelessWidget {
  String imagePath;
  String title;
  String description;
  OnboardingScreenModel({
    super.key,
    required this.imagePath,
    required this.title,
    this.description = "",
  });
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;
    return Column(
      spacing: 6,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: .center,
          children: [
            Image.asset(
              height: hight * 0.3,
              width: width * 0.7,
              alignment: AlignmentGeometry.topCenter,
              'assets/images/onbording_header.png',
            ),
          ],
        ),
        Image.asset(imagePath, width: width * 0.9, height: hight * 0.5),
        Expanded(
          child: Text(
            title,
            style: TextStyles.titleLargeStyle(color: AppColors.gold),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyles.bodySmallStyle(color: AppColors.gold),
            textAlign: .center,
          ),
        ),
      ],
    );
  }
}
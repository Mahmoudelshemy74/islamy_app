import 'package:flutter/material.dart';
import 'package:islamy_app/models/hadeth_model.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';

class HadithDetails extends StatefulWidget {
  static const routeName = 'hadithDetails';
  final Hadith hadith;
  const HadithDetails({required this.hadith, super.key});

  @override
  State<HadithDetails> createState() => _HadithDetailsState();
}

class _HadithDetailsState extends State<HadithDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/img_bottom_decoration.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/img_left_corner.png',
                        alignment: Alignment.topLeft,
                        fit: BoxFit.fitHeight,
                      ),
                      Text(
                        widget.hadith.Name,
                        style: TextStyles.titleLargeStyle(
                          color: AppColors.gold,
                        ),
                      ),
                      Image.asset(
                        'assets/images/img_right_corner.png',
                        alignment: Alignment.topRight,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        widget.hadith.Content,
                        style: TextStyles.bodyMediumStyle(
                          color: AppColors.gold,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
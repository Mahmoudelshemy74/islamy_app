import 'package:flutter/material.dart';
import 'package:islamy_app/screens/sura_details/sura_details.dart';
import 'package:islamy_app/models/sura_model.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';

class SuraItem extends StatelessWidget {
  final Sura sura; // with sura_model.dart
  Function(Sura) onItemTap;
  SuraItem({required this.sura,required this.onItemTap, super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemTap(sura);
        Navigator.pushNamed(context, SuraDetails.routeName, arguments: sura);
      },
      child: Row(
        children: [
          Stack(
            alignment: .center,
            children: [
              Image.asset('assets/images/aya_number_shape.png', height: 60),
              Text(
                sura.id.toString(),
                style: TextStyles.labelMediumStyle(color: AppColors.white),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        sura.nameEn,
                        style: TextStyles.labelMediumStyle(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        sura.versesNumber,
                        style: TextStyles.labelMediumStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  sura.nameAr,
                  style: TextStyles.labelMediumStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

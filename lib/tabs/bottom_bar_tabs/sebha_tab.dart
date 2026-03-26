import 'package:flutter/material.dart';
import 'package:islamy_app/theme/text_styles.dart';
import 'package:islamy_app/widgets/base_tab_widget.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  static const int _maxOfTasbieh = 33;
  int countOfTasabih = 0;
  int tasabiehIndex = 0;
  final List<Map<String, String>> tasbiehat = [
    {
      'header': 'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ',
      'body': 'سُبْحَانَ اللَّهِ',
    },
    {
      'header': 'وَبِحَمْدِهِ تَمْلَأُ الْمِيزَانَ',
      'body': 'الْحَمْدُ لِلَّهِ',
    },
    {'header': 'اللَّهُ أَكْبَرُ كَبِيرًا', 'body': 'اللَّهُ أَكْبَرُ'},
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    final currentTasbieh = tasbiehat[tasabiehIndex];
    return BaseTabWidget(
      showGradient: false,
      imagePath: 'assets/images/sebhaBackGround.png',
      child: SafeArea(
        child: Column(
          spacing: 7,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                Image.asset(
                  "assets/images/imageheader.png",
                  width: width * 0.8,
                  height: hight * 0.2,
                ),
              ],
            ),
            Text(
              currentTasbieh['header']!,
              style: TextStyles.titleLargeStyle(),
            ),
            GestureDetector(
              onTap: _sebhaOnTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/SebhaBody.png',
                    width: width * 0.9,
                    height: hight * 0.5,
                  ),
                  Positioned(
                    bottom: hight * 0.1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            currentTasbieh['body']!,
                            style: TextStyles.titleLargeStyle().copyWith(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '$countOfTasabih',
                          style: TextStyles.titleLargeStyle().copyWith(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sebhaOnTap() {
    setState(() {
      if (countOfTasabih >= _maxOfTasbieh) {
        countOfTasabih = 0;
        tasabiehIndex = (tasabiehIndex + 1) % tasbiehat.length;
      } else {
        countOfTasabih++;
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:islamy_app/models/onboarding_screen_model.dart';
import 'package:islamy_app/screens/home_view/home_view.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.black,
    body: Column(
      children: [
        Expanded(
          child: PageView(
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            children: [
              OnboardingScreenModel(
                imagePath: 'assets/images/first_onboarding_photo.png',
                title: 'Welcome To Islmi App',
              ),
              OnboardingScreenModel(
                imagePath: 'assets/images/second_inboarding_ph.png',
                title: 'Welcome To Islmi App',
                description: 'We Are Very Excited To Have You In Our Community',
              ),
              OnboardingScreenModel(
                imagePath: 'assets/images/Firstonbor.png',
                title: 'Reading the Quran',
                description: 'Read, and your Lord is the Most Generous',
              ),
              OnboardingScreenModel(
                imagePath: 'assets/images/Frame 4 onbpoading.png',
                title: 'Bearish',
                description: 'Praise the name of your Lord, the Most High',
              ),
              OnboardingScreenModel(
                imagePath: 'assets/images/lastonboardingframe.png',
                title: 'Holy Quran Radio',
                description:
                    'You can listen to the Holy Quran Radio through the application for free and easily',
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _currentPage == 0
                  ? null
                  : () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
              child: Text(
                "Back",
                style: _currentPage == 0
                    ? TextStyle(color: Colors.transparent)
                    : TextStyle(color: AppColors.gold),
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 5,
              effect: WormEffect(
                activeDotColor: AppColors.gold,
                dotColor: AppColors.gray,
                dotHeight: 9,
                dotWidth: 8,
              ),
            ),
            TextButton(
              onPressed: () {
                if (_currentPage == 4) {
                  Navigator.pushReplacementNamed(context, HomeView.routeName);
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                  );
                }
              },
              child: Text(
                _currentPage == 4 ? 'Finish' : 'Next',
                style: TextStyle(color: AppColors.gold),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

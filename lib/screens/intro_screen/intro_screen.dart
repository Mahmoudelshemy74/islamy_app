import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:islamy_app/screens/home_view/home_view.dart';
import 'package:islamy_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = 'introScreen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final bool seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

      if (!mounted) return;

      if (seenOnboarding) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.gold,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/Mosque-01 1.png', width: width * 0.7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/branding.png',
                        fit: BoxFit.contain,
                        width: width * 0.4,
                        height: height * 0.17,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Image.asset(
                'assets/images/islami_logo.png',
                width: width * 0.3,
                height: height * 0.3,
                fit: BoxFit.contain,
              ).zoomIn(),
            ),
          ),
          Positioned(
            right: width * 0.02,
            child: Image.asset(
              'assets/images/Candle.png',
              height: height * 0.4,
            ).slideDown(duration: Duration(milliseconds: 500)),
          ),
          Positioned(
            left: 0,
            top: 180,
            child: Image.asset(
              'assets/images/Left_IC.png',
              height: height * 0.2,
            ).slideInLeft(),
          ),
          Positioned(
            right: 0,
            bottom: 100,
            child: Image.asset(
              'assets/images/Right_IC.png',
              height: height * 0.2,
            ).slideInRight(),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:islamy_app/models/hadeth_model.dart';
import 'package:islamy_app/models/sura_model.dart';
import 'package:islamy_app/screens/hadith_details/hadith_details.dart';
import 'package:islamy_app/screens/home_view/home_view.dart';
import 'package:islamy_app/screens/intro_screen/intro_screen.dart';
import 'package:islamy_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:islamy_app/screens/sura_details/sura_details.dart';

void main() {
  runApp(IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        IntroScreen.routeName: (_) => IntroScreen(),
        HomeView.routeName: (_) => HomeView(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        SuraDetails.routeName: (context) {
          var sura = ModalRoute.of(context)!.settings.arguments as Sura;
          return SuraDetails(sura: sura);
        },
        HadithDetails.routeName: (context) {
          var hadith = ModalRoute.of(context)!.settings.arguments as Hadith;
          return HadithDetails(hadith: hadith);
        },
      },
      initialRoute: IntroScreen.routeName,
    );
  }
}

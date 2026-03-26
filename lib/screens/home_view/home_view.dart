import 'package:flutter/material.dart';
import 'package:islamy_app/tabs/bottom_bar_tabs/hadeth_tab.dart';
import 'package:islamy_app/tabs/bottom_bar_tabs/quran_tab.dart';
import 'package:islamy_app/tabs/bottom_bar_tabs/sebha_tab.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';

class HomeView extends StatefulWidget {
  static const routeName = 'homeScreen';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    HadethTab(),
    SebhaTab(),
    Container(color: Colors.yellow),
    Container(color: Colors.orange),
  ];
  late PageController pageController = PageController(
    initialPage: selectedIndex,
  );
  void initState() {
    super.initState();
    pageController.addListener(() {
      if (((pageController.page ?? 0) % 1) > 0.5) {
        selectedIndex = (pageController.page ?? 0).toInt() + 1;
      } else {
        selectedIndex = (pageController.page ?? 0).toInt();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: PageView(controller: pageController, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // same space as the selected item
        backgroundColor: AppColors.gold,
        selectedLabelStyle: TextStyles.labelSmallStyle(color: AppColors.black),
        showUnselectedLabels: false,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.black,
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == selectedIndex) {
            return;
          }
          selectedIndex = index;
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.linear,
          );

          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: _BuildBottomNavugationBarIcon("assets/images/Quran.png", 0),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: _BuildBottomNavugationBarIcon("assets/images/ahadeth.png", 1),
            label: 'Hadith',
          ),
          BottomNavigationBarItem(
            icon: _BuildBottomNavugationBarIcon("assets/images/sebha.png", 2),
            label: 'Sebha',
          ),
          BottomNavigationBarItem(
            icon: _BuildBottomNavugationBarIcon("assets/images/radio.png", 3),
            label: 'Radio',
          ),
          BottomNavigationBarItem(
            icon: _BuildBottomNavugationBarIcon("assets/images/Time.png", 4),
            label: 'Time',
          ),
        ],
      ),
    );
  }
  Widget _BuildBottomNavugationBarIcon(String ImageUrl, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: index == selectedIndex
          ? BoxDecoration(
              color: Colors.black.withAlpha(90),
              borderRadius: BorderRadius.circular(150),
            )
          : null,
      child: ImageIcon(AssetImage(ImageUrl)),
    );
  }
}
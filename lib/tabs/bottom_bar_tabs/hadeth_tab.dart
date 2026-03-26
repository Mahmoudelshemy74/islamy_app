import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy_app/models/hadeth_model.dart';
import 'package:islamy_app/screens/hadith_details/hadith_details.dart';
import 'package:islamy_app/widgets/base_tab_widget.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';

class HadethTab extends StatefulWidget {
  HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List<Hadith> ahadith = List.filled(10, Hadith(Name: "", Content: "", id: 0));

  @override
  void initState() {
    super.initState();
    loadHadith();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: BaseTabWidget(
          imagePath: 'assets/images/taj-mahal-agra-india 1.png',
          child: Column(
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset(
                      "assets/images/imageheader.png",
                      width: width * 0.7,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: ahadith.length,
                  itemBuilder: (_, index, _) => InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      HadithDetails.routeName,
                      arguments: ahadith[index],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            opacity: 50,
                            image: AssetImage(
                              'assets/images/imageHdeithBackground.png',
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ImageIcon(
                                      AssetImage(
                                        'assets/images/img_left_corner.png',
                                      ),
                                      color: AppColors.black,
                                      size: 80,
                                    ),
                                  ),
                                  Text(
                                    ahadith[index].Name,
                                    style: TextStyles.labelLargeStyle(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: ImageIcon(
                                      AssetImage(
                                        'assets/images/img_right_corner.png',
                                      ),
                                      color: AppColors.black,
                                      size: 80,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: Text(
                                    ahadith[index].Content,
                                    style: TextStyles.bodyLargeStyle(
                                      color: AppColors.black,
                                    ),
                                    textAlign: .center,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/images/Mosque-02 2.png',
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 400,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.25,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadHadith() async {
    String fileContent = await PlatformAssetBundle().loadString(
      'assets/Suras/hadeeth.txt',
    );

    List<String> hadithList = fileContent.trim().split("#");
    List<Hadith> tempList = [];

    for (int i = 0; i < hadithList.length; i++) {
      var hadithLines = hadithList[i].trim().split("\n");
      var title = hadithLines.first;
      var content = hadithLines.sublist(1).join(" ");
      tempList.add(Hadith(Name: title, Content: content, id: i));
    }

    if (mounted) {
      setState(() {
        ahadith = tempList;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:islamy_app/screens/sura_details/sura_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islamy_app/constants/shared_preferences_constants.dart';
import 'package:islamy_app/models/sura_model.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';
import 'package:islamy_app/widgets/base_tab_widget.dart';
import 'package:islamy_app/widgets/sura_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late SharedPreferences sharedPreferences;
  List<Sura> filteredList = suraList;
  List<Sura> mostRecentList = [];

  @override
  void initState() {
    super.initState();
    _getMostRecentList();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BaseTabWidget(
        imagePath: 'assets/images/taj-mahl-mosque.png',
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/imageheader.png",
                    width: width * 0.7,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: TextFormField(
                  onChanged: _onSearch,
                  style: TextStyles.labelMediumStyle(),
                  decoration: InputDecoration(
                    hintText: 'Sura Name',
                    hintStyle: TextStyles.labelMediumStyle(
                      color: AppColors.white,
                    ),
                    prefixIcon: ImageIcon(
                      AssetImage('assets/images/Quran.png'),
                      color: AppColors.gold,
                    ),
                    filled: true,
                    fillColor: AppColors.black.withAlpha(60),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.gold, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.gold, width: 0.5),
                    ),
                  ),
                ),
              ),
            ),
            if (mostRecentList.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Most Recent',
                    style: TextStyles.labelMediumStyle(color: AppColors.white),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 170,
                  width: width * 0.8,
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.gold,
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            SuraDetails.routeName,
                            arguments: mostRecentList[index],
                          );
                        },
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: .spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mostRecentList[index].nameEn,
                                  style: TextStyles.titleLargeStyle(
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  mostRecentList[index].nameAr,
                                  style: TextStyles.titleLargeStyle(
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  mostRecentList[index].versesNumber,
                                  style: TextStyles.titleLargeStyle(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset('assets/images/img_most_recent.png'),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 8),
                    itemCount: mostRecentList.length,
                  ),
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Suras list',
                  style: TextStyles.labelSmallStyle(color: AppColors.white),
                ),
              ),
            ),
            SliverList.separated(
              itemCount: filteredList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SuraItem(
                  sura: filteredList[index],
                  onItemTap: addToMostRecentList,
                ),
              ),
              separatorBuilder: (context, index) => Divider(
                color: AppColors.white,
                thickness: 0.59,
                indent: 40,
                endIndent: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearch(String content) {
    filteredList = suraList
        .where(
          (sura) =>
              sura.nameEn.toLowerCase().contains(content.toLowerCase()) ||
              sura.nameAr.contains(content),
        )
        .toList();
    setState(() {});
  }

  Future<void> _getMostRecentList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var idsList =
        sharedPreferences.getStringList(
          SharedPreferencesConstants.mostRecent.value,
        ) ??
        [];

    mostRecentList = [];
    for (int i = 0; i < idsList.length; i++) {
      int id = int.parse(idsList[i]);
      if (id >= 1 && id <= suraList.length) {
        mostRecentList.add(suraList[id - 1]);
      }
    }
    setState(() {});
  }

  Future<void> addToMostRecentList(Sura sura) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var exist = mostRecentList.removeWhere((element) => element.id == sura.id);
    var newList = [sura, ...mostRecentList];
    List<String> idsList = [];
    for (var value in newList) {
      idsList.add(value.id.toString());
    }
    await sharedPreferences.setStringList(
      SharedPreferencesConstants.mostRecent.value,
      idsList,
    );
    _getMostRecentList();
  }
}

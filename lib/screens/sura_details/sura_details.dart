import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy_app/models/sura_model.dart';
import 'package:islamy_app/theme/colors.dart';
import 'package:islamy_app/theme/text_styles.dart';

class SuraDetails extends StatefulWidget {
  static const routeName = 'suraDetails';
  final Sura sura;
  const SuraDetails({required this.sura, super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  String? suraContent;

  @override
  void initState() {
    super.initState();
    getSuraDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            'assets/images/img_bottom_decoration.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              // ── AppBar بيسكرول مع المحتوى ──
              SliverAppBar(
                toolbarHeight: 30,
                centerTitle: true,
                title: Text(widget.sura.nameEn),
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.gold,
                floating: true, // بيظهر لما تسكرول لفوق
                snap: true, // بيكمل ظهوره بسرعة
              ),

              // ── Header (الاسم العربي + الزوايا) ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/img_left_corner.png'),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.sura.nameAr,
                          style: TextStyles.titleLargeStyle(
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                      Image.asset('assets/images/img_right_corner.png'),
                    ],
                  ),
                ),
              ),

              // ── المحتوى ──
              suraContent == null
                  ? SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          suraContent!,
                          style: TextStyles.bodyMediumStyle(
                            color: AppColors.gold,
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void getSuraDetails() async {
    var ayalist;
    String suraDetailsText = await rootBundle.loadString(
      'assets/Suras/${widget.sura.id}.txt',
    );
    ayalist = suraDetailsText
        .trim()
        .split("\n")
        .map((aya) => aya.trim())
        .toList();
    suraContent = ayalist
        .asMap() //convert to map
        .entries // بيجيب كل entry فيها key(الرقم) و value(الآية)
        .map((entry) => "${entry.value} ﴿${entry.key + 1}﴾")
        .join("\n\n"); //join the map to a string
    setState(() {});
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/blocs/adBloc/bloc/ad_bloc.dart';
import 'package:clashminiguide/data/databaseApiClient.dart';
import 'package:clashminiguide/helpers/listHelper.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/helpers/themeHelper.dart';
import 'package:clashminiguide/locator.dart';
import 'package:clashminiguide/pages/profilePage/bannerEditPage.dart';
import 'package:clashminiguide/widgets/customDialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SizeHelper sizeHelper = SizeHelper();
  ThemeHelper themeHelper = ThemeHelper();
  final _scrollController = FixedExtentScrollController(initialItem: 1);
  late List<String> bannerPath;
  AdBloc adBloc = getIt<AdBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerPath = minisList.map((e) => e.assetPath).toList();
  }

  int selectedBannerIndex = 0;

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[
      Colors.pinkAccent,
      Colors.indigoAccent,
      Colors.cyanAccent,
      Colors.lightBlueAccent,
      Colors.deepPurpleAccent
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    DatabaseApiClient databaseApiClient = getIt<DatabaseApiClient>();
    /*databaseApiClient.saveComps(Comps(
        title: "Powerfull Archer Queen Deck",
        bannerPhotoUrl:
            "https://firebasestorage.googleapis.com/v0/b/clashminiguide.appspot.com/o/banners%2FarcherDeck.png?alt=media&token=42986b77-d2a8-43f9-bfe8-d6c173596e8b",
        mapPhotoUrl:
            "https://firebasestorage.googleapis.com/v0/b/clashminiguide.appspot.com/o/banners%2Farcherqueenamazing.png?alt=media&token=06459ff1-7197-4d03-876f-b9611535b6a0",
        tricks: [
          Trick(title: "0", value: "Miner"),
          Trick(title: "1", value: "Electiral Wizard"),
          Trick(title: "2", value: "Archer"),
        ],
        isAdded: false,
        isPriced: false));*/
    return MultiBlocListener(
      listeners: [
        BlocListener(
            bloc: adBloc,
            listener: (context, state) {
              if (state is RewardEarned) {
                debugPrint(" AAAAAASDCASDCASDCASDCASDCASDCASDCASDAS earned");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BannerEditPage(
                            bannerPath: bannerPath[selectedBannerIndex], bannerString: "Your Nickname")));
              }
            })
      ],
      child: Container(
        color: Colors.lightGreenAccent,
        width: sizeHelper.width,
        height: sizeHelper.height,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: sizeHelper.height! * 0.075,
                width: sizeHelper.width! * 0.5,
                child: AutoSizeText(
                  "banner_title".tr(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: GoogleFonts.luckiestGuy(color: Colors.blue, fontSize: 40),
                ),
              ),
              SizedBox(
                height: sizeHelper.height! * 0.5,
                width: sizeHelper.width,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                              assetPath: "assets/minis/magicArcher.png",
                              adBloc: adBloc,
                              dialogType: 2,
                              sizeHelper: sizeHelper,
                              nopeButtpnString: "nope_string".tr(),
                              okButtonString: "banner_ok_string".tr(),
                              subjectString: "banner_sentences".tr(),
                              topicString: "banner_topic".tr());
                        });
                  },
                  child: ListWheelScrollView.useDelegate(
                    squeeze: 1.1,
                    controller: _scrollController,
                    itemExtent: sizeHelper.height! * 0.15,
                    physics: const FixedExtentScrollPhysics(),
                    overAndUnderCenterOpacity: 0.7,
                    perspective: 0.001,
                    onSelectedItemChanged: (index) {
                      selectedBannerIndex = index;
                      debugPrint("onSelectedItemChanged index: $index ");
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        String bannerString = "write_nick".tr();
                        /*for (AchievedBanner banner in bannerList!) {
                                if (banner.name == bannerPath[index]) bannerString = banner.inBannerString;
                              }*/
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: sizeHelper.width,
                              height: sizeHelper.height! * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage("assets/banners/backBanner.png"), fit: BoxFit.fill)),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        width: sizeHelper.width! * 0.5,
                                        child: AutoSizeText(
                                          bannerString,
                                          maxLines: 1,
                                          style: GoogleFonts.lilitaOne(
                                              fontSize: 30, foreground: Paint()..shader = linearGradient),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        height: sizeHelper.height! * 0.2,
                                        width: sizeHelper.width! * 0.5,
                                        child: Image.asset(bannerPath[index]),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                      childCount: bannerPath.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/blocs/adBloc/bloc/ad_bloc.dart';
import 'package:clashminiguide/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/locator.dart';
import 'package:clashminiguide/models/comps.dart';
import 'package:clashminiguide/pages/compDetailPage/compDetailPage.dart';
import 'package:clashminiguide/widgets/miniImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SizeHelper sizeHelper = SizeHelper();

  late DatabaseBloc databaseBloc;

  AdBloc adBloc = getIt<AdBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adBloc.add(InitializeIntersAd());
    databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc.add(GetComps(dateTime: DateTime.now()));
  }

  List<Comps>? comps;
  Comps? clickedCurrentComp;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DatabaseBloc, DatabaseState>(
          bloc: databaseBloc,
          listener: (context, state) {
            if (state is CompsLoading) {
              EasyLoading.show();
            } else if (state is CompsLoaded) {
              EasyLoading.dismiss();
              setState(() {
                comps = state.comps;
              });
            } else if (state is CompsLoadError) {
              EasyLoading.dismiss();

              debugPrint(state.error);
            }
          },
        ),
        BlocListener<AdBloc, AdState>(
          bloc: adBloc,
          listener: (context, state) {
            if (state is RewardEarned) {
              debugPrint(" AAAAAASDCASDCASDCASDCASDCASDCASDCASDAS earned");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CompDetailPage(currentComp: clickedCurrentComp!)));
            }
          },
        ),
      ],
      child: Container(
        height: sizeHelper.height,
        width: sizeHelper.width,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: sizeHelper.height! * 0.075,
                width: sizeHelper.width! * 0.5,
                child: AutoSizeText(
                  "best_comps".tr(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.luckiestGuy(color: Colors.blue, fontSize: 40),
                ),
              ),
              comps != null
                  ? SizedBox(
                      height: sizeHelper.height! * 0.75,
                      child: ListView.builder(
                          itemCount: comps!.length,
                          itemBuilder: (context, index) {
                            Comps currentComp = comps![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (currentComp.isAdded!) {
                                    EasyLoading.show();
                                    clickedCurrentComp = currentComp;
                                    adBloc.add(ShowRewardedAd());
                                  } else {
                                    adBloc.add(ShowIntersAd());
                                    adBloc.add(InitializeIntersAd());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CompDetailPage(currentComp: currentComp)));
                                  }
                                },
                                child: Container(
                                  height: sizeHelper.height! * 0.2,
                                  width: sizeHelper.width! * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            height: sizeHelper.height! * 0.2,
                                            width: sizeHelper.width! * 0.9,
                                            child: MiniNetworkImage(
                                              imageURL: currentComp.bannerPhotoUrl!,
                                            ),
                                          ),
                                        ),
                                        currentComp.isHot!
                                            ? Positioned(
                                                top: 0,
                                                right: currentComp.isAdded! ? sizeHelper.height! * 0.07 - 10 : 0,
                                                child: Container(
                                                  height: sizeHelper.height! * 0.07,
                                                  width: sizeHelper.height! * 0.07,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.amberAccent,
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                                                  child: Center(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(right: currentComp.isAdded! ? 10 : 0),
                                                    child: AutoSizeText(
                                                      "HOT",
                                                      style: GoogleFonts.luckiestGuy(color: Colors.red, fontSize: 20),
                                                    ),
                                                  )),
                                                ),
                                              )
                                            : const SizedBox(),
                                        currentComp.isAdded!
                                            ? Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: sizeHelper.height! * 0.07,
                                                  width: sizeHelper.height! * 0.07,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                                                  child: const Icon(LineIcons.ad, size: 50, color: Colors.amberAccent),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

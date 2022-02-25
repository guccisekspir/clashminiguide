import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/models/comps.dart';
import 'package:clashminiguide/widgets/miniImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class CompDetailPage extends StatelessWidget {
  final Comps currentComp;
  const CompDetailPage({Key? key, required this.currentComp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper();
    //ThemeHelper themeHelper = ThemeHelper();

    return SizedBox(
      height: sizeHelper.height,
      width: sizeHelper.width,
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: sizeHelper.height! * 1.5,
            width: sizeHelper.width,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 40,
                        )),
                  ),
                ),
                SizedBox(
                  height: sizeHelper.height! * 0.075,
                  width: sizeHelper.width! * 0.5,
                  child: AutoSizeText(
                    currentComp.title!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.luckiestGuy(color: Colors.blue, fontSize: 40),
                  ),
                ),
                SizedBox(
                  height: sizeHelper.height! * 0.6,
                  width: sizeHelper.width! * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MiniNetworkImage(
                      imageURL: currentComp.mapPhotoUrl!,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: sizeHelper.height! * 0.075,
                  width: sizeHelper.width! * 0.5,
                  child: AutoSizeText(
                    "tricks".tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.luckiestGuy(color: Colors.blue, fontSize: 40),
                  ),
                ),
                SizedBox(
                  height: currentComp.tricks!.length * sizeHelper.height! * 0.15,
                  child: ListView.builder(
                      itemCount: currentComp.tricks?.length ?? 0,
                      itemBuilder: (context, index) {
                        Trick currentTrick = currentComp.tricks![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: sizeHelper.height! * 0.05,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notification_important,
                                  color: Colors.red,
                                  size: sizeHelper.width! * 0.1,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: sizeHelper.width! * 0.5),
                                  child: AutoSizeText(
                                    currentTrick.title!.tr() + "; ",
                                    maxLines: 1,
                                    style: GoogleFonts.luckiestGuy(
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: sizeHelper.width! * 0.3),
                                  child: AutoSizeText(
                                    currentTrick.value!,
                                    style: GoogleFonts.luckiestGuy(
                                      color: Colors.blue,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

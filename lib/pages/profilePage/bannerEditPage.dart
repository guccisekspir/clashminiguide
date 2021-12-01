import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BannerEditPage extends StatefulWidget {
  final String bannerPath;
  final String bannerString;

  const BannerEditPage({Key? key, required this.bannerPath, required this.bannerString}) : super(key: key);
  @override
  _BannerEditPageState createState() => _BannerEditPageState();
}

class _BannerEditPageState extends State<BannerEditPage> {
  SizeHelper sizeHelper = SizeHelper();

  late TextEditingController textEditingController;

  //HiveBloc hiveBloc = getIt<HiveBloc>();

  @override
  void initState() {
    // TODO: implement initState

    textEditingController = TextEditingController(text: widget.bannerString);
    super.initState();
    textEditingController.addListener(() {
      setState(() {});
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  captureShot() async {
    String? path;
    final directory = (await getApplicationDocumentsDirectory()).path; //from path_provide package
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    path = '$directory';

    String? annen = await screenshotController.captureAndSave(path, //set path where screenshot will be saved
        fileName: fileName);

    if (annen != null) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "image_save".tr(),
        ),
      );
    }

    debugPrint(annen ?? "aasdadas");
  }

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightGreenAccent,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
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
          Text("edit_banner_title".tr(), style: GoogleFonts.lilitaOne(color: Colors.black, fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(counterStyle: GoogleFonts.lilitaOne(color: Colors.black, fontSize: 20)),
              controller: textEditingController,
              maxLength: 14,
              maxLines: 1,
              style: GoogleFonts.lilitaOne(color: Colors.white, fontSize: 30),
            ),
          ),
          Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: sizeHelper.width,
                  height: sizeHelper.height! * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image:
                          const DecorationImage(image: AssetImage("assets/banners/backBanner.png"), fit: BoxFit.fill)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: sizeHelper.width! * 0.5,
                            child: AutoSizeText(
                              textEditingController.text,
                              maxLines: 1,
                              style: GoogleFonts.lilitaOne(fontSize: 30, foreground: Paint()..shader = linearGradient),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(width: sizeHelper.width! * 0.5, child: Image.asset(widget.bannerPath)),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await captureShot();
                /*hiveBloc.add(SaveBanner(
                    achievedBanner: AchievedBanner(
                        widget.bannerPath, textEditingController.text)));
                Future.delayed(Duration(milliseconds: 100)).then((value) => {
                      hiveBloc.add(GetAchievedBanner()),
                    });
                Navigator.pop(context);*/
              },
              child: AutoSizeText("save".tr()))
        ],
      ),
    );
  }
}

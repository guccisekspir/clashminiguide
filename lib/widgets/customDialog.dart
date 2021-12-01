import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/blocs/adBloc/bloc/ad_bloc.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final SizeHelper sizeHelper;
  final AdBloc? adBloc;
  final String okButtonString;
  final String nopeButtpnString;
  final String topicString;
  final String subjectString;
  final String assetPath;
  final int dialogType;

  const CustomDialog(
      {Key? key,
      required this.assetPath,
      required this.dialogType,
      required this.sizeHelper,
      required this.nopeButtpnString,
      required this.okButtonString,
      required this.subjectString,
      this.adBloc,
      required this.topicString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 40),
        child: Builder(
          builder: (context) {
            return SizedBox(
                height: sizeHelper.height! * 0.6,
                width: sizeHelper.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: SizedBox(
                        height: sizeHelper.height! * 0.2,
                        child: Image.asset(
                          assetPath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: sizeHelper.height! * 0.4,
                        decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                        width: sizeHelper.width,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: AutoSizeText(
                                topicString,
                                style:
                                    GoogleFonts.lilitaOne(color: Colors.lightBlue, fontSize: sizeHelper.height! * 0.05),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Center(
                                child: AutoSizeText(
                                  subjectString,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style:
                                      GoogleFonts.lilitaOne(color: Colors.white, fontSize: sizeHelper.height! * 0.03),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MaterialButton(
                                    padding: EdgeInsets.zero,
                                    elevation: 20,
                                    splashColor: Colors.amber,
                                    color: Colors.blueAccent,
                                    minWidth: sizeHelper.width! * 0.6,
                                    onPressed: () {
                                      EasyLoading.show();
                                      adBloc!.add(ShowRewardedAd());
                                      Navigator.pop(context);
                                    },
                                    child: Text(okButtonString),
                                  ),
                                  MaterialButton(
                                    color: Colors.blueAccent,
                                    elevation: 20,
                                    splashColor: Colors.amber,
                                    minWidth: sizeHelper.width! * 0.6,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(nopeButtpnString),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}

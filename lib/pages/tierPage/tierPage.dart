import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:clashminiguide/helpers/listHelper.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/helpers/themeHelper.dart';
import 'package:clashminiguide/models/minis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class TierPage extends StatelessWidget {
  const TierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    DatabaseBloc databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc.add(GetTierList(dateTime: DateTime.now()));

    return Container(
      width: sizeHelper.width,
      height: sizeHelper.height,
      child: BlocBuilder(
          bloc: databaseBloc,
          builder: (context, state) {
            if (state is TierListLoading) {
              EasyLoading.show();
            } else if (state is TierListLoaded) {
              EasyLoading.dismiss();
              List<int> tierList = state.tierList.tierList!;
              return Container(
                color: themeHelper.backgroundColor,
                height: sizeHelper.height,
                width: sizeHelper.width,
                child: SafeArea(
                  child: Container(
                    height: sizeHelper.height,
                    width: sizeHelper.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: sizeHelper.height! * 0.075,
                          width: sizeHelper.width! * 0.5,
                          child: AutoSizeText(
                            "Tier List ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.luckiestGuy(color: Colors.blue, fontSize: 40),
                          ),
                        ),
                        SizedBox(
                          height: sizeHelper.height! * 0.75,
                          width: sizeHelper.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: tierList.length,
                              itemBuilder: (context, index) {
                                Minis currentMinis = minisList[tierList[index]];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: sizeHelper.height! * 0.1,
                                    width: sizeHelper.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: index < 5
                                          ? Colors.red
                                          : index < 10
                                              ? Colors.amber
                                              : index < 15
                                                  ? Colors.lightGreen
                                                  : Colors.grey,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: sizeHelper.height! * 0.1,
                                            width: sizeHelper.width! * 0.1,
                                            child: Center(
                                              child: AutoSizeText(
                                                (index + 1).toString() + ".",
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.luckiestGuy(color: Colors.white, fontSize: 30),
                                              ),
                                            )),
                                        Container(
                                          height: sizeHelper.height! * 0.1,
                                          width: sizeHelper.width! * 0.15,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(currentMinis.assetPath), fit: BoxFit.fill)),
                                        ),
                                        SizedBox(
                                            height: sizeHelper.height! * 0.1,
                                            width: sizeHelper.width! * 0.7,
                                            child: Center(
                                              child: AutoSizeText(
                                                currentMinis.name,
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.luckiestGuy(color: Colors.white, fontSize: 30),
                                              ),
                                            ))
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
              );
            } else if (state is TierListLoadError) {
              debugPrint(state.error);
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizeHelper.height! * 0.4,
                      ),
                      Text("Hata oluştu sonra tekrar deneyin"),
                      IconButton(
                          onPressed: () {
                            databaseBloc.add(GetTierList(dateTime: DateTime.now()));
                          },
                          icon: const Icon(Icons.refresh, size: 50, color: Colors.greenAccent))
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }
}

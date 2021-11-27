import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashminiguide/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/models/comps.dart';
import 'package:clashminiguide/pages/compDetailPage/compDetailPage.dart';
import 'package:clashminiguide/widgets/miniImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SizeHelper sizeHelper = SizeHelper();

  late DatabaseBloc databaseBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    databaseBloc.add(GetComps(dateTime: DateTime.now()));
  }

  List<Comps>? comps;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabaseBloc, DatabaseState>(
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
                  "Best Team Comps",
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompDetailPage(currentComp: currentComp)));
                                },
                                child: Container(
                                  height: sizeHelper.height! * 0.2,
                                  width: sizeHelper.width! * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: MiniNetworkImage(
                                      imageURL: currentComp.bannerPhotoUrl!,
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

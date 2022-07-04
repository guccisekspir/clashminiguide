// ignore_for_file: unused_field

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:clashminiguide/blocs/navigationBloc.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/helpers/themeHelper.dart';
import 'package:clashminiguide/pages/homePage/homePage.dart';
import 'package:clashminiguide/pages/profilePage/profilePage.dart';
import 'package:clashminiguide/pages/tierPage/tierPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        if (activeIndex == 1) {
          activeIndex = 2;
          _bottomNavBarBloc.pickItem(2);
        }

        break;
      case AppLifecycleState.paused:
        debugPrint('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        debugPrint('appLifeCycleState detached');
        break;
    }
  }

  late BottomNavBarBloc _bottomNavBarBloc;
  final SizeHelper sizeHelper = SizeHelper();
  ThemeHelper themeHelper = ThemeHelper();

  bool isConnected = true;

  //TODO user gelmeme durumunda sharedPref bak yoksa oturumdan çıkış yap tekrar girmesini iste

  int activeIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);

    sharedUserKaydet("aaa");
    _bottomNavBarBloc = BottomNavBarBloc();

    super.initState();
  }

  int bottomNavBarIndex = 0;

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //Safe areada ne gözükmesini istiyorsan onu yapmak gerekiyor
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!) {
              case NavBarItem.HOME:
                return BlocProvider(
                  create: (context) => DatabaseBloc(),
                  child: const HomePage(),
                );
              case NavBarItem.TIER:
                return BlocProvider(
                  create: (context) => DatabaseBloc(),
                  child: const TierPage(),
                );
              case NavBarItem.PROFILE:
                return const ProfilePage();
            }
          }
          return Container();
        },
      ),
      bottomNavigationBar: StreamBuilder(
          //blocdaki streami dinlemek
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (context, snapshot) {
            return AnimatedBottomNavigationBar.builder(
              backgroundColor: Colors.amber,
              splashColor: Colors.blue,
              activeIndex: bottomNavBarIndex,
              gapLocation: GapLocation.none,

              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) => setState(() => {_bottomNavBarBloc.pickItem(index), bottomNavBarIndex = index}),
              itemCount: 3,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? Colors.blue : Colors.black;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AutoSizeText(
                        navbarString[index],
                        maxLines: 1,
                        style: GoogleFonts.lilitaOne(color: color),
                      ),
                    )
                  ],
                );
              },
              //other params
            );
          }),
    );
  }

  List<IconData> iconList = [LineIcons.chessBoard, Icons.leaderboard, LineIcons.award];

  List<String> navbarString = ["Decks", "Tier List", "Lab"];

  Future<void> sharedUserKaydet(String userID) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", userID);
  }
}

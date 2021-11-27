// ignore_for_file: unused_field

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/blocs/databaseBloc/bloc/database_bloc.dart';
import 'package:clashminiguide/blocs/navigationBloc.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/helpers/themeHelper.dart';
import 'package:clashminiguide/pages/homePage/homePage.dart';
import 'package:clashminiguide/pages/profilePage/profilePage.dart';
import 'package:clashminiguide/pages/quizPage/quizPage.dart';
import 'package:clashminiguide/pages/tierPage/tierPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rive/rive.dart' hide LinearGradient;
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
          triggers[activeIndex]?.change(false);
          triggers[2]?.change(true);
          activeIndex = 2;
          _bottomNavBarBloc.pickItem(2);
        }

        //rebuildAllChildren();

        /// _coreApiBloc.add(ExitToPlace());
        /*
        Future.delayed(Duration(milliseconds: 100)).then((value) =>
            _coreApiBloc.add(EnterToPlace(
                userID: widget.currentUser.userId!,
                enteredPlaceID: widget.enteredPlace.uid!)));*/
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
  //late DatabaseBloc _databaseBloc;

  //final NotificationBloc _notificationBloc = getIt<NotificationBloc>();
  final SizeHelper sizeHelper = SizeHelper();
  ThemeHelper themeHelper = ThemeHelper();

  bool isConnected = true;

  //TODO user gelmeme durumunda sharedPref bak yoksa oturumdan çıkış yap tekrar girmesini iste
  //

  Artboard? _homeArtboard;
  SMIBool? homeTrigger;

  Artboard? _statArtboard;
  SMIBool? statTrigger;

  Artboard? _locationArtboard;
  SMIBool? locationTrigger;

  Artboard? _profileArtboard;
  SMIBool? profileTrigger;

  List<Artboard?> artboards = [null, null, null, null, null];
  List<SMIBool?> triggers = [null, null, null, null, null];

  int activeIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
/*
    rootBundle.load('assets/rives/navigationRives/home.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'homeState');
        if (controller != null) {
          artboard.addController(controller);

          homeTrigger = controller.findInput<bool>("isHome") as SMIBool;
          triggers[0] = homeTrigger;
        }
        homeTrigger?.change(true);
        setState(() => {artboards[0] = artboard, _homeArtboard = artboard});
      },
    );
    rootBundle.load('assets/rives/navigationRives/search.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'searchState');
        if (controller != null) {
          artboard.addController(controller);

          locationTrigger = controller.findInput<bool>("isLSearch") as SMIBool;
          triggers[1] = locationTrigger;
        }
        setState(() => {artboards[1] = artboard, _locationArtboard = artboard});
      },
    );
    rootBundle.load('assets/rives/navigationRives/add.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'addState');
        if (controller != null) {
          artboard.addController(controller);
          statTrigger = controller.findInput<bool>("isAdd") as SMIBool;
          triggers[2] = statTrigger;
        }
        setState(() => {artboards[2] = artboard, _statArtboard = artboard});
      },
    );
    rootBundle.load('assets/rives/navigationRives/notification.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'notificationState');
        if (controller != null) {
          artboard.addController(controller);
          statTrigger = controller.findInput<bool>("isNotification") as SMIBool;
          triggers[3] = statTrigger;
        }
        setState(() => {artboards[3] = artboard, _statArtboard = artboard});
      },
    );
    rootBundle.load('assets/rives/navigationRives/profile.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'profileState');
        if (controller != null) {
          artboard.addController(controller);

          profileTrigger = controller.findInput<bool>("isProfile") as SMIBool;
          triggers[4] = profileTrigger;
        }
        setState(() => {artboards[4] = artboard, _profileArtboard = artboard});
      },
    );*/

    /*_notificationBloc
        .add(GetNotifications(currentUserID: widget.gelenUser.userId!));
    _notificationBloc.add(SaveToken());
    controllerBloc = BlocProvider.of<ControllerBloc>(context);
    controllerBloc.add(ControllInternetConnection());*/
    //_databaseBloc = BlocProvider.of<DatabaseBloc>(context);
    //_databaseBloc.add(ControllAuthState());

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
    GlobalKey _curvedKey = GlobalKey();

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
                  child: HomePage(),
                );
              case NavBarItem.TIER:
                return BlocProvider(
                  create: (context) => DatabaseBloc(),
                  child: TierPage(),
                );
              case NavBarItem.QUIZ:
                return QuizPage();
              case NavBarItem.NOTIF:
                return QuizPage();
              case NavBarItem.PROFILE:
                return ProfilePage();
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
              itemCount: 5,
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

  List<IconData> iconList = [Icons.deck, Icons.leaderboard, Icons.quiz, Icons.ac_unit, Icons.verified_user];

  List<String> navbarString = ["Decks", "TierList", "Quizes", "Quizes2", "Profile"];

  Future<void> sharedUserKaydet(String userID) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", userID);
  }
}

/*class MyDelegateBuilder extends DelegateBuilder {
  final List<Artboard?> artboards;
  SizeHelper sizeHelper = SizeHelper();

  MyDelegateBuilder(this.artboards);
  @override
  Widget build(BuildContext context, int index, bool active) {
    return SizedBox(
      width: active ? sizeHelper.height! * 0.06 : sizeHelper.height! * 0.055,
      height: active ? sizeHelper.height! * 0.06 : sizeHelper.height! * 0.055,
      child: artboards[index] != null
          ? Rive(
              artboard: artboards[index]!,
            )
          : Container(),
    );
  }
}*/

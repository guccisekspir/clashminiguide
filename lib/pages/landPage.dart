import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/pages/navigationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class LandPage extends StatefulWidget {
  final bool isFirst;

  const LandPage({Key? key, required this.isFirst}) : super(key: key);
  @override
  _LandPageState createState() => _LandPageState();
}

//eğer giriş yapmamışsa

class _LandPageState extends State<LandPage> {
  String? userID = "";

  bool isSharedLoaded = false;

  //NotificationHelper notificationHelper = NotificationHelper();

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 10)
      ..animationDuration = const Duration(milliseconds: 10)
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = 45.0
      ..radius = 20.0
      ..progressColor = Colors.pinkAccent
      ..backgroundColor = Colors.white.withOpacity(0.1)
      ..indicatorColor = Colors.pinkAccent
      ..textColor = Colors.pinkAccent
      ..maskColor = Colors.black.withOpacity(0.7)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  //InitializerBloc initializerBloc = getIt<InitializerBloc>();
  //NotificationHelper notificationHelper = getIt<NotificationHelper>();

  @override
  void initState() {
    //initializerBloc.add(StartInitializing());
    /*FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);
    debugPrint("Lange geldi");*/
    configLoading();
    /* notificationHelper.initializeFCMNotification(context);

    _databaseBloc = BlocProvider.of<DatabaseBloc>(context);*/
    sharedFunction();
    super.initState();
  }

  //land pagede sadece eğer her şeyi yapmışsa homepage'e yönlendiriyoruz öteki türlü yine login page'e gidilcek ( çıkış yapmış olabilir, doldurmamış olabilir)
  @override
  Widget build(BuildContext context) {
    {
      if (isSharedLoaded) {
        //Shared gelene kadar userID null olduğu için burada o kontrolü yapıyoruz
        if ((widget.isFirst)) {
          SizeHelper(fetchedContext: context);

          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WithPages()), (Route<dynamic> route) => false);
          });
        } else {
          SizeHelper(fetchedContext: context);

          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => NavigationPage()), (Route<dynamic> route) => false);
          });
        }
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.amberAccent,
              child: Text("A"),
            ),
          ),
        ),
      );
    }
  }

  Future<void> sharedFunction() async {
    debugPrint("shared geldi geldi");
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    setState(() {
      //giriş yapıp yapmadığı kontrol ediliyor
      isSharedLoaded = true;
      if (prefs.getBool("isFirst") == null) {
        debugPrint("isfirst" + prefs.getBool("isFirst").toString());
        prefs.clear();
        prefs.setBool("isFirst", false);
        debugPrint("isfirst" + prefs.getBool("isFirst").toString());
      } else {
        if (prefs.getString("userID") != null) {
          userID = prefs.getString("userID");
          debugPrint("user geldi" + userID!);
          //if (userID != null) _databaseBloc.add(GetUser(userID!));
          //TODO checklensin authstate
        }
      }
    });
  }
}

class WithPages extends StatefulWidget {
  static final style = GoogleFonts.luckiestGuy(color: Colors.white, fontSize: 30);

  @override
  _WithPages createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  int page = 0;
  late LiquidController liquidController;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    Container(
      width: 800,
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              'assets/logoString.png',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                "page1_sentences1".tr(),
                style: WithPages.style,
              ),
              Text(
                "page1_sentences2".tr(),
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      width: 800,
      color: Colors.amberAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/minis/pekka.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Text(
                "page2_sentences1".tr(),
                style: WithPages.style,
              ),
              Text(
                "page2_sentences2".tr(),
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      width: 800,
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/minis/giantSkeleton.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Text(
                "page3_sentences1".tr(),
                style: WithPages.style,
              ),
              Text(
                "page3_sentences2".tr(),
                style: WithPages.style,
              ),
              Text(
                "page3_sentences3".tr(),
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      width: 800,
      color: Colors.lightBlueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/minis/valkrie.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Text(
                "Gotta",
                style: WithPages.style,
              ),
              Text(
                "Solve",
                style: WithPages.style,
              ),
              Text(
                "'Em All",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - (page - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  SizeHelper sizeHelper = SizeHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: sizeHelper.width,
            height: sizeHelper.height,
            child: LiquidSwipe(
              pages: pages,
              positionSlideIcon: 0.8,
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                size: 40,
              ),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(pages.length, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationPage()), (route) => false);
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: sizeHelper.width! * 0.17,
                    maxWidth: sizeHelper.width! * 0.17,
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: AutoSizeText(
                      "skip".tr(),
                      style: WithPages.style,
                    )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    debugPrint("page" + lpage.toString());
    setState(() {
      page = lpage;
    });
  }
}

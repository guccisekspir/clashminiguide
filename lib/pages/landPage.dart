import 'dart:isolate';

import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:clashminiguide/helpers/themeHelper.dart';
import 'package:clashminiguide/pages/navigationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        if (widget.isFirst) {
          SizeHelper(fetchedContext: context);

          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => Container(
                          color: Colors.redAccent,
                        )),
                (Route<dynamic> route) => false);
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

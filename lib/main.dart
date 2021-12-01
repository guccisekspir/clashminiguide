import 'package:clashminiguide/locator.dart';
import 'package:clashminiguide/pages/landPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  MobileAds.instance.initialize();

  MobileAds.instance
      .updateRequestConfiguration(RequestConfiguration(testDeviceIds: ["84E809EDF0BEF25961F6196A69B56CF0"]));

  await Firebase.initializeApp();

  //await FirebaseAppCheck.instance.activate();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirst = false;
  if (prefs.getBool("isFirst") == null) {
    debugPrint("isfirst" + prefs.getBool("isFirst").toString());
    isFirst = true;

    debugPrint("isfirst" + prefs.getBool("isFirst").toString());
  }

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('tr'), Locale('es')],
        useOnlyLangCode: true,
        path: 'assets/translations', // <-- change the path of the translation files
        child: App(
          isFirst: isFirst,
        )),
  );
}

class App extends StatelessWidget {
  final bool isFirst;
  const App({Key? key, required this.isFirst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*  navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],*/

      title: 'ClashMiniGuide',
      localizationsDelegates: context.localizationDelegates,
      // <-- add this
      supportedLocales: context.supportedLocales,
      // <-- add this
      locale: context.locale,
      theme: ThemeData(
        hintColor: Colors.white,
        hoverColor: Colors.white,
        primarySwatch: Colors.green,
        primaryColor: const Color(0XFF00C02C),
        scaffoldBackgroundColor: const Color(0XFFEEEEEE),
        errorColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandPage(
        isFirst: isFirst,
      ),

      builder: EasyLoading.init(),
    );
  }
}

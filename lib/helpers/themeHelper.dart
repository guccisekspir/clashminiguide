import 'package:clashminiguide/helpers/sizeHelper.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  Color backgroundColor = const Color(0XFFEEEEEE);
  Color surfaceColor = const Color(0XFFFFFFFF);
  //Color lightSurfaceColor = const Color(0XFF303030);
  Color primaryColor = const Color(0XFF00C02C);
  Color secondaryColor = const Color(0XFFAA14F0);
  Color onBackground = Colors.black;
  Color onSurface = Colors.black;
  Color onSurfaceLight = Colors.black54;
  Color onPrimary = Colors.white;
  Color onSecondary = Colors.white;
  Color accentSpring = const Color(0xFF00FFBB);
  Color accentAqua = const Color(0xFF00FFFF);
  Color accentFushia = const Color(0xFFEF0386);

  BuildContext? ccontext;
  TextTheme? themeData;
  Sizes sizes = Sizes();

  SizeHelper sizeHelper = SizeHelper();

  static final ThemeHelper _themeHelper = ThemeHelper._internal();

  ThemeHelper._internal();

  factory ThemeHelper({BuildContext? fetchedContext}) {
    //LnadPage'de context'i verdiğimiz için sonraki yerlerde
    //tekrar tekrar çağırmamak için bunu yapıyoruz
    if (fetchedContext != null) {
      _themeHelper.ccontext = fetchedContext;

      if (_themeHelper.themeData == null) {
        _themeHelper.themeData = Theme.of(fetchedContext).textTheme;
      }
    }

    return _themeHelper;
  }
}

class Sizes {
  SizeHelper sizeHelper = SizeHelper();

  Sizes();
}

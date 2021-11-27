import 'dart:io';

class AdHelper {
  static String get intersAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7158700897724379/4449418925';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7158700897724379/3491560474';
    }
    return "ca-app-pub-7158700897724379/4449418925";
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7158700897724379/3874703853';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7158700897724379/7047662101';
    }
    return "ca-app-pub-7158700897724379/3874703853";
  }
}

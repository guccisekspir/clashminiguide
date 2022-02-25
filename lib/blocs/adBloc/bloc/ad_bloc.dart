import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clashminiguide/helpers/adHelper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  InterstitialAd? loadedInterstitialAd;

  RewardedAd? rewardedAd;
  bool isRewarded = false;

  AdBloc() : super(AdInitial()) {
    on<AdEvent>((event, emit) {
      if (event is InitializeIntersAd) {
        InterstitialAd.load(
            adUnitId: AdHelper.intersAdUnitId,
            request: const AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (InterstitialAd ad) {
                // Keep a reference to the ad so you can show it later.
                loadedInterstitialAd = ad;
              },
              onAdFailedToLoad: (LoadAdError error) {
                log('InterstitialAd failed to load: $error');
              },
            ));
        if (loadedInterstitialAd == null) {
        } else {
          log("Null dil");
        }
      } else if (event is ShowIntersAd) {
        if (loadedInterstitialAd != null) {
          loadedInterstitialAd!.show();
          loadedInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) => log('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              emit(IntersAdShowed(DateTime.now().millisecondsSinceEpoch));
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              log('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) => log('$ad impression occurred.'),
          );
        } else {
          add(InitializeIntersAd());
          log("Null");
        }
      } else if (event is LoadRewardedAd) {
      } else if (event is ShowRewardedAd) {
        //rewardedQuiz = event.rewardedQuiz;
        RewardedAd.load(
            adUnitId: AdHelper.rewardedAdUnitId,
            request: const AdRequest(),
            rewardedAdLoadCallback: RewardedAdLoadCallback(
              onAdLoaded: (RewardedAd ad) {
                if (kDebugMode) {
                  print('$ad loaded show.');
                }
                // Keep a reference to the ad so you can show it later.
                EasyLoading.dismiss();
                rewardedAd = ad;
                rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
                  onAdShowedFullScreenContent: (RewardedAd ad) => debugPrint('$ad onAdShowedFullScreenContent.'),
                  onAdDismissedFullScreenContent: (RewardedAd ad) {
                    if (kDebugMode) {
                      print('$ad aaaaaaaaonAdDismissedFullScreenContent.');
                    }
                    //this.emit(RewardEarned(DateTime.now().millisecondsSinceEpoch));

                    ad.dispose();
                  },
                  onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
                    if (kDebugMode) {
                      print('$ad onAdFailedToShowFullScreenContent: $error');
                    }
                    ad.dispose();
                    if (isRewarded) {
                      //this.emit(RewardEarned(DateTime.now().millisecondsSinceEpoch));
                      isRewarded = false;
                    }
                  },
                  onAdImpression: (RewardedAd ad) => debugPrint('$ad impression occurred.'),
                );
                rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
                  debugPrint('oldu loaded show.');
                  isRewarded = true;

                  emit(RewardEarned(
                    DateTime.now().millisecondsSinceEpoch,
                  ));
                });
              },
              onAdFailedToLoad: (LoadAdError error) {
                debugPrint('RewardedAd failed to load: $error');
              },
            ));
      }
    });
  }
}

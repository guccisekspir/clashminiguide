part of 'ad_bloc.dart';

abstract class AdEvent extends Equatable {
  const AdEvent();
  @override
  List<Object?> get props => [];
}

class InitializeIntersAd extends AdEvent {}

class LoadIntersAd extends AdEvent {}

class ShowIntersAd extends AdEvent {}

class LoadRewardedAd extends AdEvent {
  final DateTime timeStamp;

  const LoadRewardedAd(this.timeStamp);
}

class ShowRewardedAd extends AdEvent {}

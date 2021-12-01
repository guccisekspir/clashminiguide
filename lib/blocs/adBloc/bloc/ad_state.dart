part of 'ad_bloc.dart';

abstract class AdState extends Equatable {
  const AdState();
}

class AdInitial extends AdState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class IntersAdShowed extends AdState {
  final int timeStamp;

  const IntersAdShowed(this.timeStamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp];
}

class RewardEarned extends AdState {
  final int timeStamp;

  const RewardEarned(
    this.timeStamp,
  );
  @override
  // TODO: implement props
  List<Object?> get props => [
        timeStamp,
      ];
}

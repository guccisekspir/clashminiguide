part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class TierListLoading extends DatabaseState {}

class TierListLoaded extends DatabaseState {
  final TierList tierList;

  const TierListLoaded(this.tierList);
}

class TierListLoadError extends DatabaseState {
  final String error;

  const TierListLoadError(this.error);
}

class CompsLoading extends DatabaseState {}

class CompsLoaded extends DatabaseState {
  final List<Comps> comps;

  const CompsLoaded(this.comps);
}

class CompsLoadError extends DatabaseState {
  final String error;

  const CompsLoadError(this.error);
}

part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class GetComps extends DatabaseEvent {
  final DateTime dateTime;

  const GetComps({required this.dateTime});
}

class GetTierList extends DatabaseEvent {
  final DateTime dateTime;

  const GetTierList({required this.dateTime});
}

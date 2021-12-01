import 'package:bloc/bloc.dart';
import 'package:clashminiguide/data/databaseRepository.dart';
import 'package:clashminiguide/locator.dart';
import 'package:clashminiguide/models/comps.dart';
import 'package:clashminiguide/models/tierList.dart';
import 'package:equatable/equatable.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  TierList? willTierList;
  List<Comps>? willComps;
  DatabaseRepository databaseRepository = getIt<DatabaseRepository>();
  DatabaseBloc() : super(DatabaseInitial()) {
    on<DatabaseEvent>((event, emit) async {
      if (event is GetTierList) {
        emit(TierListLoading());
        try {
          if (willTierList == null) {
            willTierList = await databaseRepository.getTierList();
            emit(TierListLoaded(willTierList!));
          } else {
            emit(TierListLoaded(willTierList!));
          }
        } catch (e) {
          emit(TierListLoadError(e.toString()));
        }
      } else if (event is GetComps) {
        emit(CompsLoading());
        try {
          if (willComps == null) {
            willComps = await databaseRepository.getComps();
            emit(CompsLoaded(willComps!));
          } else {
            emit(CompsLoaded(willComps!));
          }
        } catch (e) {
          emit(CompsLoadError(e.toString()));
        }
      }
    });
  }
}

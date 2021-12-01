import 'package:clashminiguide/blocs/adBloc/bloc/ad_bloc.dart';
import 'package:clashminiguide/data/databaseApiClient.dart';
import 'package:clashminiguide/data/databaseRepository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerLazySingleton<DatabaseRepository>(() => DatabaseRepository());
  getIt.registerLazySingleton<DatabaseApiClient>(() => DatabaseApiClient());

  getIt.registerLazySingleton<AdBloc>(() => AdBloc());
}

import 'package:clashminiguide/data/databaseApiClient.dart';
import 'package:clashminiguide/locator.dart';
import 'package:clashminiguide/models/comps.dart';
import 'package:clashminiguide/models/tierList.dart';

class DatabaseRepository {
  DatabaseApiClient databaseApiClient = getIt<DatabaseApiClient>();

  Future<List<Comps>> getComps() async {
    return await databaseApiClient.getComps();
  }

  Future<TierList> getTierList() async {
    return await databaseApiClient.getTierList();
  }
}

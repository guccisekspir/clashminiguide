import 'dart:developer';

import 'package:clashminiguide/models/comps.dart';
import 'package:clashminiguide/models/tierList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseApiClient {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Comps>> getComps() async {
    List<Comps> comps = [];

    QuerySnapshot compSnapshot = await firestore.collection("comps").get();

    for (var element in compSnapshot.docs) {
      if (element.exists) {
        comps.add(Comps.fromMap(element.data() as Map<String, dynamic>));
      }
    }

    return comps;
  }

  saveComps(Comps comp) async {
    DocumentReference ref = firestore.collection("comps").doc();
    Comps willSaveComp = comp;
    willSaveComp.id = ref.id;

    ref.set(willSaveComp.toMap());
  }

  Future<TierList> getTierList() async {
    log("geldi");
    TierList tierList = TierList();
    DocumentSnapshot tierSnapshot = await firestore.collection("defined").doc("tierList").get();

    tierList = TierList.fromMap(tierSnapshot.data() as Map<String, dynamic>);
    log(tierSnapshot.data().toString());
    return tierList;
  }
}

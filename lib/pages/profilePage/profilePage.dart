import 'package:clashminiguide/data/databaseApiClient.dart';
import 'package:clashminiguide/locator.dart';
import 'package:clashminiguide/models/comps.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseApiClient databaseApiClient = getIt<DatabaseApiClient>();
    /*databaseApiClient.saveComps(Comps(
        title: "Powerfull Archer Queen Deck",
        bannerPhotoUrl:
            "https://firebasestorage.googleapis.com/v0/b/clashminiguide.appspot.com/o/banners%2FarcherDeck.png?alt=media&token=42986b77-d2a8-43f9-bfe8-d6c173596e8b",
        mapPhotoUrl:
            "https://firebasestorage.googleapis.com/v0/b/clashminiguide.appspot.com/o/banners%2Farcherqueenamazing.png?alt=media&token=06459ff1-7197-4d03-876f-b9611535b6a0",
        tricks: [
          Trick(title: "0", value: "Miner"),
          Trick(title: "1", value: "Electiral Wizard"),
          Trick(title: "2", value: "Archer"),
        ],
        isAdded: false,
        isPriced: false));*/
    return Container(
      color: Colors.lightGreenAccent,
    );
  }
}

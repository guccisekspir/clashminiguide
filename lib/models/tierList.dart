// To parse this JSON data, do
//
//     final tierList = tierListFromMap(jsonString);

import 'dart:convert';

class TierList {
  TierList({
    this.tierList,
  });

  List<int>? tierList;

  factory TierList.fromJson(String str) => TierList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TierList.fromMap(Map<String, dynamic> json) => TierList(
        tierList: json["tierList"] == null ? null : List<int>.from(json["tierList"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "tierList": tierList == null ? null : List<dynamic>.from(tierList!.map((x) => x)),
      };
}

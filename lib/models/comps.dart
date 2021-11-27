// To parse this JSON data, do
//
//     final comps = compsFromMap(jsonString);

import 'dart:convert';

class Comps {
  Comps({this.id, this.title, this.bannerPhotoUrl, this.tricks, this.mapPhotoUrl, this.isAdded, this.isPriced});

  String? id;
  String? title;
  String? bannerPhotoUrl;
  List<Trick>? tricks;
  String? mapPhotoUrl;
  bool? isPriced;
  bool? isAdded;

  factory Comps.fromJson(String str) => Comps.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comps.fromMap(Map<String, dynamic> json) => Comps(
        isPriced: json["isPriced"] == null ? false : json["isPriced"],
        isAdded: json["isAdded"] == null ? false : json["isAdded"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        bannerPhotoUrl: json["banner_photo_url"] == null ? null : json["banner_photo_url"],
        tricks: json["tricks"] == null ? null : List<Trick>.from(json["tricks"].map((x) => Trick.fromMap(x))),
        mapPhotoUrl: json["map_photo_url"] == null ? null : json["map_photo_url"],
      );

  Map<String, dynamic> toMap() => {
        "isPriced": id == null ? false : isPriced,
        "isAdded": id == null ? false : isAdded,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "banner_photo_url": bannerPhotoUrl == null ? null : bannerPhotoUrl,
        "tricks": tricks == null ? null : List<dynamic>.from(tricks!.map((x) => x.toMap())),
        "map_photo_url": mapPhotoUrl == null ? null : mapPhotoUrl,
      };
}

class Trick {
  Trick({this.title, this.value});

  String? title;
  String? value;

  factory Trick.fromJson(String str) => Trick.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Trick.fromMap(Map<String, dynamic> json) => Trick(
        value: json["value"] == null ? null : json["value"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "title": title == null ? null : title,
      };
}

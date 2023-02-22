// To parse this JSON data, do
//
//     final ad = adFromMap(jsonString);

import 'dart:convert';

List<Ad> adFromMap(String str) => List<Ad>.from(json.decode(str).map((x) => Ad.fromMap(x)));

String adToMap(List<Ad> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Ad {
    Ad({
        this.id,
        this.title,
        this.assets,
        this.description,
        this.duration,
        this.type,
        this.createdAt,
        this.updateAt,
        this.v,
        this.adId,
    });

    String? id;
    String ?title;
    List<String>? assets;
    String ?description;
    int ?duration;
    String? type;
    DateTime? createdAt;
    DateTime? updateAt;
    int ?v;
    String ?adId;

    factory Ad.fromMap(Map<String, dynamic> json) => Ad(
        id: json["_id"],
        title: json["title"],
        assets: List<String>.from(json["assets"].map((x) => x)),
        description: json["description"],
        duration: json["duration"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updateAt: DateTime.parse(json["updateAt"]),
        v: json["__v"],
        adId: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "assets": List<dynamic>.from(assets!.map((x) => x)),
        "description": description,
        "duration": duration,
        "type": type,
        "createdAt": createdAt!.toIso8601String(),
        "updateAt": updateAt!.toIso8601String(),
        "__v": v,
        "id": adId,
    };
}

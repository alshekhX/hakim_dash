// To parse this JSON data, do
//
//     final homeCare = homeCareFromJson(jsonString);

import 'dart:convert';

List<HomeCare> homeCareFromJson(String str) => List<HomeCare>.from(json.decode(str).map((x) => HomeCare.fromJson(x)));


class HomeCare {
    HomeCare({
        this.id,
        this.name,
        this.assets,
        this.phone,
        this.location,
        this.description,
        this.createdAt,
        this.v,
        this.homeCareId,
    });

    String? id;
    String? name;
    List<String>? assets;
    List<String>? phone;
    String? location;
    String? description;
    DateTime? createdAt;
    int? v;
    String? homeCareId;

    factory HomeCare.fromJson(Map<String, dynamic> json) => HomeCare(
        id: json["_id"],
        name: json["name"],
        assets: List<String>.from(json["assets"].map((x) => x)),
        phone: List<String>.from(json["phone"].map((x) => x)),
        location: json["location"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        homeCareId: json["id"],
    );

}

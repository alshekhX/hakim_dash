// To parse this JSON data, do
//
//     final hospital = hospitalFromJson(jsonString);

import 'dart:convert';

List<Hospital> hospitalFromJson(String str) => List<Hospital>.from(json.decode(str).map((x) => Hospital.fromJson(x)));


class Hospital {
    Hospital({
        this.id,
        this.name,
        this.assets,
        this.location,
        this.phone,
        this.description,
        this.createdAt,
        this.v,
        this.hospitalId,
    });

    String? id;
    String? name;
    List<String>? assets;
    String ?location;
    List<String>? phone;
    String ?description;
    DateTime? createdAt;
    int ?v;
    String? hospitalId;

    factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["_id"],
        name: json["name"],
        assets: List<String>.from(json["assets"].map((x) => x)),
        location: json["location"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        hospitalId: json["id"],
    );

}

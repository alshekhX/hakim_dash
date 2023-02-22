// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

List<Doctor> doctorFromJson(String str) => List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));


class Doctor {
    Doctor({
        this.category,
        this.id,
        this.username,
        this.email,
        this.phone,
        this.firstName,
        this.lastName,
        this.description,
        this.photo,
        this.mainHospital,
        this.rank,
        this.createdAt,
        this.v,
        this.doctorId,
    });

    String? category;
        String? rank;

    String? id;
    String? username;
    String ?email;
    List<String>? phone;
    String ?firstName;
    String ?lastName;
    String ?description;
    String ?photo;
    String ?mainHospital;
    DateTime ?createdAt;
    int ?v;
    String ?doctorId;

    factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        category: json["category"] == null ?null:json["category"],
                rank: json["rank"] == null ?null:json["rank"],

        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : List<String>.from(json["phone"].map((x) => x)),
        firstName: json["firstname"] == null ? null : json["firstname"],
        lastName: json["lastname"] == null ? null : json["lastname"],
        description: json["description"] == null ? null : json["description"],
        photo: json["photo"] == null ? null : json["photo"],
        mainHospital: json["mainHospital"] == null ? null : json["mainHospital"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"] == null ? null : json["__v"],
        doctorId: json["id"] == null ? null : json["id"],
    );

}

// To parse this JSON data, do
//
//     final clubUser = clubUserFromJson(jsonString);

import 'dart:convert';

ClubUser clubUserFromJson(String str) => ClubUser.fromJson(json.decode(str));

String clubUserToJson(ClubUser data) => json.encode(data.toJson());

class ClubUser {
    int? id;
    String? name;
    String? clubId;
    dynamic charterDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? district;
    String? type;
    int? isActive;
    dynamic image;
    dynamic description;
    dynamic email;

    ClubUser({
        required this.id,
        required this.name,
        required this.clubId,
        required this.charterDate,
        required this.createdAt,
        required this.updatedAt,
        required this.district,
        required this.type,
        required this.isActive,
        required this.image,
        required this.description,
        required this.email,
    });

    factory ClubUser.fromJson(Map<String, dynamic> json) => ClubUser(
        id: json["id"],
        name: json["name"],
        clubId: json["club_id"],
        charterDate: json["charter_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        district: json["district"],
        type: json["type"],
        isActive: json["is_active"],
        image: json["image"],
        description: json["description"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "club_id": clubId,
        "charter_date": charterDate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "district": district,
        "type": type,
        "is_active": isActive,
        "image": image,
        "description": description,
        "email": email,
    };
}

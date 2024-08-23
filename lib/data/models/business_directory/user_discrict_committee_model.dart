// To parse this JSON data, do
//
//     final userDistrictCommittee = userDistrictCommitteeFromJson(jsonString);

import 'dart:convert';

UserDistrictCommittee userDistrictCommitteeFromJson(String str) => UserDistrictCommittee.fromJson(json.decode(str));

String userDistrictCommitteeToJson(UserDistrictCommittee data) => json.encode(data.toJson());

class UserDistrictCommittee {
    final int? id;
    final String? councilId;
    final String? userId;
    final DateTime? activeFrom;
    final DateTime? activeTo;
    final String? isPastDir;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? role;
    final Council? council;

    UserDistrictCommittee({
        this.id,
        this.councilId,
        this.userId,
        this.activeFrom,
        this.activeTo,
        this.isPastDir,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.council,
    });

    factory UserDistrictCommittee.fromJson(Map<String, dynamic> json) => UserDistrictCommittee(
        id: json["id"],
        councilId: json["council_id"],
        userId: json["user_id"],
        activeFrom: json["active_from"] == null ? null : DateTime.parse(json["active_from"]),
        activeTo: json["active_to"] == null ? null : DateTime.parse(json["active_to"]),
        isPastDir: json["is_past_dir"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        role: json["role"],
        council: json["council"] == null ? null : Council.fromJson(json["council"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "council_id": councilId,
        "user_id": userId,
        "active_from": "${activeFrom!.year.toString().padLeft(4, '0')}-${activeFrom!.month.toString().padLeft(2, '0')}-${activeFrom!.day.toString().padLeft(2, '0')}",
        "active_to": "${activeTo!.year.toString().padLeft(4, '0')}-${activeTo!.month.toString().padLeft(2, '0')}-${activeTo!.day.toString().padLeft(2, '0')}",
        "is_past_dir": isPastDir,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role,
        "council": council?.toJson(),
    };
}

class Council {
    final int? id;
    final String? name;

    Council({
        this.id,
        this.name,
    });

    factory Council.fromJson(Map<String, dynamic> json) => Council(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

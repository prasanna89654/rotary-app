// To parse this JSON data, do
//
//     final userClubRoles = userClubRolesFromJson(jsonString);

import 'dart:convert';

UserClubRoles userClubRolesFromJson(String str) => UserClubRoles.fromJson(json.decode(str));

String userClubRolesToJson(UserClubRoles data) => json.encode(data.toJson());

class UserClubRoles {
    final int? id;
    final int? userId;
    final String? category;
    final String? role;
    final DateTime? activeFrom;
    final DateTime? activeTo;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic councilId;
    final String? clubId;
    final int? status;
    final dynamic roleOrder;

    UserClubRoles({
        this.id,
        this.userId,
        this.category,
        this.role,
        this.activeFrom,
        this.activeTo,
        this.createdAt,
        this.updatedAt,
        this.councilId,
        this.clubId,
        this.status,
        this.roleOrder,
    });

    factory UserClubRoles.fromJson(Map<String, dynamic> json) => UserClubRoles(
        id: json["id"],
        userId: json["user_id"],
        category: json["category"],
        role: json["role"],
        activeFrom: json["active_from"] == null ? null : DateTime.parse(json["active_from"]),
        activeTo: json["active_to"] == null ? null : DateTime.parse(json["active_to"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        councilId: json["council_id"],
        clubId: json["club_id"],
        status: json["status"],
        roleOrder: json["role_order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category": category,
        "role": role,
        "active_from": "${activeFrom!.year.toString().padLeft(4, '0')}-${activeFrom!.month.toString().padLeft(2, '0')}-${activeFrom!.day.toString().padLeft(2, '0')}",
        "active_to": "${activeTo!.year.toString().padLeft(4, '0')}-${activeTo!.month.toString().padLeft(2, '0')}-${activeTo!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "council_id": councilId,
        "club_id": clubId,
        "status": status,
        "role_order": roleOrder,
    };
}

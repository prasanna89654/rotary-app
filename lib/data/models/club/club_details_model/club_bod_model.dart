class ClubBoardOfDirectorsModel {
  ClubBoardOfDirectorsModel({
    this.role,
    this.name,
  });

  String? role;
  String? name;

  factory ClubBoardOfDirectorsModel.fromJson(Map<String, dynamic> json) =>
      ClubBoardOfDirectorsModel(
        role: json["role"] == null ? null : json["role"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "name": name,
      };
}

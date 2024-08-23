class ClubTopMembers {
  ClubTopMembers({
    this.president,
    this.secretary,
  });

  President? president;
  President? secretary;

  factory ClubTopMembers.fromJson(Map<String, dynamic> json) => ClubTopMembers(
        president: json['president'] == null
            ? null
            : President.fromJson(json["president"]),
        secretary: json['secretary'] == null
            ? null
            : President.fromJson(json["secretary"]),
      );
}

class President {
  President({
    this.name,
    this.image,
    this.year,
  });

  String? name;
  String? image;
  String? year;

  factory President.fromJson(Map<String, dynamic> json) => President(
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        year: json["year"] == null ? null : json["year"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "year": year,
      };
}

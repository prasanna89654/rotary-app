class ClubDetailsRequestModel {
  ClubDetailsRequestModel({
    required this.id,
  });

  final String id;

  factory ClubDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      ClubDetailsRequestModel(id: json['id'] as String);

  Map<String, dynamic> toJson() => {'id': id};
}

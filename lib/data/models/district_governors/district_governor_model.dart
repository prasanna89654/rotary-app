import 'package:rotary/domain/entities/district_governors/district_governor_entities.dart';

class DistrictGovernorModel extends DistrictGovernorEntities {
  final String? id;
  final String? userId;
  final String? name;
  final String? activeYear;
  final String? description;
  final String? image;
  final String? club;
  final String? email;

  const DistrictGovernorModel(
      {this.id,
      this.userId,
      this.name,
      this.activeYear,
      this.description,
      this.image,
      this.club,
      this.email})
      : super(
          id: id,
          userId: userId,
          name: name,
          activeYear: activeYear,
          description: description,
          image: image,
          club: club,
          email: email,
        );

  factory DistrictGovernorModel.fromJson(Map<String, dynamic> json) {
    return DistrictGovernorModel(
        id: json['id'] as String?,
        userId: json['user_id'] as String?,
        name: json['name'] as String?,
        activeYear: json['active_year'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        club: json['club'] as String?,
        email: json['email'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'active_year': activeYear,
        'description': description,
        'image': image,
        'club': club,
        'email': email,
      };
}

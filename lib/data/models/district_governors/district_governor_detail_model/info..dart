import 'package:equatable/equatable.dart';

class DistrictGovernorDetailInfo extends Equatable {
  final String? name;
  final String? image;
  final String? activeYear;
  final String? description;

  const DistrictGovernorDetailInfo(
      {this.name, this.image, this.activeYear, this.description});

  factory DistrictGovernorDetailInfo.fromJson(Map<String, dynamic> json) =>
      DistrictGovernorDetailInfo(
        name: json['name'] as String?,
        image: json['image'] as String?,
        activeYear: json['active_year'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'active_year': activeYear,
        'description': description,
      };

  @override
  List<Object?> get props => [name, image, activeYear, description];
}

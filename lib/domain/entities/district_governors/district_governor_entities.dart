import 'package:equatable/equatable.dart';

class DistrictGovernorEntities extends Equatable {
  final String? id;
  final String? userId;
  final String? name;
  final String? activeYear;
  final String? description;
  final String? image;
  final String? club;
  final String? email;

  const DistrictGovernorEntities(
      {this.id,
      this.userId,
      this.name,
      this.activeYear,
      this.description,
      this.image,
      this.club,
      this.email});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      name,
      activeYear,
      description,
      image,
      club,
    ];
  }
}

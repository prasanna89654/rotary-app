import 'package:rotary/domain/entities/district_committee/district_committee_entities.dart';

class DistrictCommitteeModel extends DistrictCommitteeEntities {
  final String? councilName;
  final String? name;
  final String? image;
  final String? position;
  final List<DistrictCommitteeMembersModel>? members;
  final bool isMain;
  DistrictCommitteeModel({
    this.councilName,
    this.name,
    this.image,
    this.position,
    this.members,
    this.isMain = false,
  }) : super(
          councilName: councilName,
          name: name,
          image: image,
          position: position,
          members: members,
          isMain: isMain,
        );

  factory DistrictCommitteeModel.fromJson(Map<String, dynamic> json) {
    return DistrictCommitteeModel(
      councilName: json['council_name'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      position: json['position'] as String?,
      members: json['members'] == null
          ? null
          : (json['members'] as List<dynamic>)
              .map((e) => DistrictCommitteeMembersModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'council_name': councilName,
        'name': name,
        'image': image,
        'position': position,
        'members': members,
      };
}

class DistrictCommitteeMembersModel extends DistrictCommitteeMembersEntities {
  final String? name;
  final String? image;
  final String? position;
  DistrictCommitteeMembersModel({
    this.name,
    this.image,
    this.position,
  }) : super(
          name: name,
          image: image,
          position: position,
        );

  factory DistrictCommitteeMembersModel.fromJson(Map<String, dynamic> json) {
    return DistrictCommitteeMembersModel(
      name: json['name'] as String?,
      image: json['image'] as String?,
      position: json['position'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'position': position,
      };
}

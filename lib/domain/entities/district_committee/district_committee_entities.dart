import 'package:equatable/equatable.dart';

class DistrictCommitteeEntities extends Equatable {
  final String? councilName;
  final String? name;
  final String? image;
  final String? position;
  final List<DistrictCommitteeMembersEntities>? members;
  final bool isMain;

  const DistrictCommitteeEntities({
    this.councilName,
    this.name,
    this.image,
    this.position,
    this.members,
    this.isMain = false,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [councilName, name, image, position, members];
}

class DistrictCommitteeMembersEntities extends Equatable {
  final String? name;
  final String? image;
  final String? position;

  const DistrictCommitteeMembersEntities({
    this.name,
    this.image,
    this.position,
  });

  @override
  List<Object?> get props => [name, image, position];
}

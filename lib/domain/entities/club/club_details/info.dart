import 'package:equatable/equatable.dart';

class ClubInfo extends Equatable {
  final String? club;
  final String? clubId;
  final String? charterDate;
  final int? number;
  final String? meetingDay;
  final String? meetingTime;
  final String? meetingVenue;
  final String? areaCode;
  final String? rotract;
  final String? interact;
  final String? rcc;
  final String? grantProject;
  final String? phf;
  final String? mphf;
  final String? rfsm;

  const ClubInfo({
    this.club,
    this.clubId,
    this.charterDate,
    this.number,
    this.meetingDay,
    this.meetingTime,
    this.meetingVenue,
    this.areaCode,
    this.rotract,
    this.interact,
    this.rcc,
    this.grantProject,
    this.phf,
    this.mphf,
    this.rfsm,
  });

  @override
  List<Object?> get props {
    return [
      club,
      clubId,
      charterDate,
      number,
      meetingDay,
      meetingTime,
      meetingVenue,
      areaCode,
      rotract,
      interact,
      rcc,
      grantProject,
      phf,
      mphf,
      rfsm,
    ];
  }
}

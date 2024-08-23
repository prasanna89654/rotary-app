import 'package:rotary/domain/entities/club/club_details/info.dart';

class ClubInfoModel extends ClubInfo {
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

  ClubInfoModel({
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
  }) : super(
          club: club,
          clubId: clubId,
          charterDate: charterDate,
          number: number,
          meetingDay: meetingDay,
          meetingTime: meetingTime,
          meetingVenue: meetingVenue,
          areaCode: areaCode,
          rotract: rotract,
          interact: interact,
          rcc: rcc,
          grantProject: grantProject,
          phf: phf,
          mphf: mphf,
          rfsm: rfsm,
        );

  factory ClubInfoModel.fromJson(Map<String, dynamic> json) => ClubInfoModel(
        club: json['club'] as String?,
        clubId: json['club_id'] as String?,
        charterDate: json['charter_date'] as String?,
        number: json['number'] as int?,
        meetingDay: json['meeting_day'] as String?,
        meetingTime: json['meeting_time'] as String?,
        meetingVenue: json['meeting_venue'] as String?,
        areaCode: json['area_code'] as String?,
        rotract: json['rotract'] as String?,
        interact: json['interact'] as String?,
        rcc: json['rcc'] as String?,
        grantProject: json['grant_project'] as String?,
        phf: json['phf'] as String?,
        mphf: json['mphf'] as String?,
        rfsm: json['rfsm'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'club': club,
        'club_id': clubId,
        'charter_date': charterDate,
        'number': number,
        'meeting_day': meetingDay,
        'meeting_time': meetingTime,
        'meeting_venue': meetingVenue,
        'area_code': areaCode,
        'rotract': rotract,
        'interact': interact,
        'rcc': rcc,
        'grant_project': grantProject,
        'phf': phf,
        'mphf': mphf,
        'rfsm': rfsm,
      };
}

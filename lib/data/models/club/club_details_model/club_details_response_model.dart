import 'package:rotary/data/models/club/club_details_model/club_bod_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_info_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_members_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_top_members_model.dart';

import '../../../../domain/entities/club/club_details/info.dart';
import '../../../../domain/entities/club/club_details/member.dart';

class ClubDetailsResponseModel {
  final ClubInfo? info;
  final List<ClubMember>? members;
  final List<ClubBoardOfDirectorsModel>? bod;
  final ClubTopMembers? topMembers;
  ClubDetailsResponseModel({
    this.info,
    this.members,
    this.bod,
    this.topMembers,
  });

  factory ClubDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ClubDetailsResponseModel(
        info: json['info'] == null
            ? null
            : ClubInfoModel.fromJson(json['info'] as Map<String, dynamic>),
        members: json['members'] == null
            ? null
            : List<ClubMembersModel>.from(
                    json['members'].map((x) => ClubMembersModel.fromJson(x)))
                .toList(),
        bod: json['board_of_director'] == null
            ? null
            : List<ClubBoardOfDirectorsModel>.from(json['board_of_director']
                .map((x) => ClubBoardOfDirectorsModel.fromJson(x))).toList(),
        topMembers: json['top_members'] == null
            ? null
            : ClubTopMembers.fromJson(
                json['top_members'] as Map<String, dynamic>),
      );
}

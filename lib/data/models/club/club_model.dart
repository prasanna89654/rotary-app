import 'package:rotary/domain/entities/club/club.dart';

class ClubsModel extends Clubs {
  ClubsModel({
    required this.clubs,
  }) : super(clubs: clubs);

  final List<ClubModel> clubs;

  factory ClubsModel.fromJson(List json) => ClubsModel(
        clubs: List<ClubModel>.from(json.map((x) => ClubModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clubs": List<dynamic>.from(clubs.map((x) => x.toJson())),
      };
}

class ClubModel extends Club {
  final String president;
  final String club;
  final String id;
  final String year;
  final int memberCount;
  ClubModel({
    required this.president,
    required this.club,
    required this.id,
    required this.year,
    required this.memberCount,
  }) : super(
          president: president,
          club: club,
          id: id,
          year: year,
          memberCount: memberCount,
        );

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      president: json['president'],
      club: json['club'],
      id: json['id'],
      year: json['year'],
      memberCount: json['member_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'president': president,
      'club': club,
      'id': id,
      'year': year,
      'member_count': memberCount,
    };
  }
}

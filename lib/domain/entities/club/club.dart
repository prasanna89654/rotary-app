import 'package:equatable/equatable.dart';

class Clubs {
  final List<Club> clubs;

  Clubs({required this.clubs});
}

class Club extends Equatable {
  final String id;
  final String president;
  final String club;
  final String year;
  final int memberCount;

  Club(
      {required this.id,
      required this.president,
      required this.club,
      required this.year,
      required this.memberCount});

  @override
  List<Object?> get props => [president, club, year, memberCount];
}

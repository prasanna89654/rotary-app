import 'package:equatable/equatable.dart';

class DistrictGovernorDetailHistory extends Equatable {
  final String? year;
  final String? position;
  final String? name;

  const DistrictGovernorDetailHistory({this.year, this.position, this.name});

  factory DistrictGovernorDetailHistory.fromJson(Map<String, dynamic> json) =>
      DistrictGovernorDetailHistory(
        year: json['year'] as String?,
        position: json['position'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
        'position': position,
        'name': name,
      };

  @override
  List<Object?> get props => [year, position, name];
}

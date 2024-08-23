import 'package:equatable/equatable.dart';

class Upcoming extends Equatable {
  final String? id;
  final String? title;
  final String? date;
  final String? location;
  final String? time;

  const Upcoming({
    this.id,
    this.title,
    this.date,
    this.location,
    this.time,
  });

  factory Upcoming.fromJson(Map<String, dynamic> json) => Upcoming(
        id: json['id'] as String?,
        title: json['title'] as String?,
        date: json['date'] as String?,
        location: json['location'] as String?,
        time: json['time'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'location': location,
        'time': time,
      };

  @override
  List<Object?> get props => [id, title, date, location, time];
}

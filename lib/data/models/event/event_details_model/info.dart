import 'package:equatable/equatable.dart';

class EventDetailInfo extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? date;
  final String? fromTime;
  final String? toTime;
  final String? location;

  const EventDetailInfo({
    this.id,
    this.title,
    this.description,
    this.date,
    this.fromTime,
    this.toTime,
    this.location,
  });

  factory EventDetailInfo.fromJson(Map<String, dynamic> json) =>
      EventDetailInfo(
        id: json['id'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        date: json['date'] as String?,
        fromTime: json['from_time'] as String?,
        toTime: json['to_time'] as String?,
        location: json['location'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
        'from_time': fromTime,
        'to_time': toTime,
        'location': location,
      };

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      date,
      fromTime,
      toTime,
      location,
    ];
  }
}

import 'package:rotary/domain/entities/event/event_entities.dart';

class EventModel extends EventEntities {
  final dynamic id;
  final String? title;
  final String? date;
  final String? fromTime;
  final String? toTime;
  final String? location;

  const EventModel({
    this.id,
    this.title,
    this.date,
    this.fromTime,
    this.toTime,
    this.location,
  }) : super(
          id: id,
          title: title,
          date: date,
          fromTime: fromTime,
          toTime: toTime,
          location: location,
        );

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'],
        title: json['title'] as String?,
        date: json['date'] as String?,
        fromTime: json['from_time'] as String?,
        toTime: json['to_time'] as String?,
        location: json['location'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'from_time': fromTime,
        'to_time': toTime,
        'location': location,
      };

  getDate() {
    DateTime date = DateTime.parse(this.date.toString());
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }
}

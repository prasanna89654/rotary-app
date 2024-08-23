import 'package:equatable/equatable.dart';

class EventEntities extends Equatable {
  final dynamic id;
  final String? title;
  final String? date;
  final String? fromTime;
  final String? toTime;
  final String? location;

  const EventEntities({
    this.id,
    this.title,
    this.date,
    this.fromTime,
    this.toTime,
    this.location,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      date,
      fromTime,
      toTime,
      location,
    ];
  }
}

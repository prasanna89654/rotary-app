import 'package:equatable/equatable.dart';

import 'info.dart';
import 'upcoming.dart';

class EventDetailsModel extends Equatable {
  final EventDetailInfo? info;
  final List<Upcoming>? upcoming;

  const EventDetailsModel({this.info, this.upcoming});

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      info: json['info'] == null
          ? null
          : EventDetailInfo.fromJson(json['info'] as Map<String, dynamic>),
      upcoming: (json['upcoming'] as List<dynamic>?)
          ?.map((e) => Upcoming.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'info': info?.toJson(),
        'upcoming': upcoming?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [info, upcoming];
}

import 'package:rotary/data/models/event/event_model.dart';

class EventResponseModel {
  List<EventModel>? upcommingEvents;

  EventResponseModel({this.upcommingEvents});

  factory EventResponseModel.fromJson(Map<String, dynamic> json) =>
      EventResponseModel(
        upcommingEvents: (json['data'] as List<dynamic>?)
            ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': upcommingEvents?.map((e) => e.toJson()).toList(),
      };
}

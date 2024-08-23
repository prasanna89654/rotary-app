import 'package:rotary/data/models/news/news_model.dart';
import 'package:rotary/data/models/notification/notification_response.dart';
import 'package:rotary/domain/entities/home/home_entities/dg.dart';
import 'package:rotary/domain/entities/home/home_entities/footer.dart';
import 'package:rotary/domain/entities/home/home_entities/home_entities.dart';
import 'package:rotary/domain/entities/home/home_entities/slider.dart';

import '../event/event_model.dart';

class HomeModel extends HomeEntities {
  final String? aboutRotatory;
  final List<EventModel>? events;
  final List<NewsModel>? news;
  final List<Slider>? slider;
  final Dg? dg;
  final Footer? footer;
  final NotificationResponseModel? notification;

  const HomeModel(
      {this.aboutRotatory,
      this.slider,
      this.dg,
      this.footer,
      this.events,
      this.news,
      this.notification})
      : super(
            aboutRotatory: aboutRotatory,
            slider: slider,
            dg: dg,
            footer: footer);

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        aboutRotatory:
            json['about_rotatory'] == null ? null : json['about_rotatory'],
        slider: (json['slider'] as List<dynamic>?)
            ?.map((e) => Slider.fromJson(e as Map<String, dynamic>))
            .toList(),
        dg: json['dg'] == null
            ? null
            : Dg.fromJson(json['dg'] as Map<String, dynamic>),
        footer: json['footer'] == null
            ? null
            : Footer.fromJson(json['footer'] as Map<String, dynamic>),
        events: json['events'] == null
            ? null
            : (json['events'] as List<dynamic>?)
                ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>))
                .toList(),
        news: json['news'] == null
            ? null
            : (json['news'] as List<dynamic>?)
                ?.map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
                .toList(),
        notification: json['notifications'] == null
            ? null
            : NotificationResponseModel.fromJson(
                json['notifications'],
              ),
      );

  Map<String, dynamic> toJson() => {
        'about_rotatory': aboutRotatory,
        'slider': slider?.map((e) => e.toJson()).toList(),
        'dg': dg?.toJson(),
        'footer': footer?.toJson(),
        'events': events?.map((e) => e.toJson()).toList(),
        'news': news?.map((e) => e.toJson()).toList(),
      };
}

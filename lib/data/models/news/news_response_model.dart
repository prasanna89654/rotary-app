import 'package:equatable/equatable.dart';
import 'package:rotary/data/models/news/news_model.dart';

class NewsResponseModel extends Equatable {
  List<NewsModel>? news;

  NewsResponseModel({this.news});

  @override
  List<Object?> get props => [news];

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsResponseModel(
        news: List<NewsModel>.from(
            json["data"].map((x) => NewsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news!.map((x) => x.toJson())),
      };
}

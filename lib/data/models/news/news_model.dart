import 'package:intl/intl.dart';

import '../../../domain/entities/news/news_entities.dart';

class NewsModel extends NewsEntity {
  NewsModel({
    this.id,
    this.club,
    this.title,
    this.imageUrl,
    this.publishDate,
    this.description,
    this.slug,
  }) : super(
          id: id,
          club: club,
          title: title,
          imageUrl: imageUrl,
          publishDate: publishDate,
          description: description,
          slug: slug,
        );

  final String? id;
  String? club;
  String? title;
  String? imageUrl;
  DateTime? publishDate;
  String? description;
  String? slug;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'],
        club: json['club'],
        title: json['title'],
        imageUrl: json['image_url'],
        publishDate: DateTime.parse(json['publish_date']),
        description: json['description'],
        slug: json['slug'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'club': club,
        'title': title,
        'image_url': imageUrl,
        'publish_date':
            "${publishDate!.year.toString().padLeft(4, '0')}-${publishDate!.month.toString().padLeft(2, '0')}-${publishDate!.day.toString().padLeft(2, '0')}",
        'description': description,
        'slug': slug,
      };

  String getFormattedDate() {
    DateFormat formattedDate = DateFormat.yMMMd();
    return formattedDate.format(publishDate!);
  }
}

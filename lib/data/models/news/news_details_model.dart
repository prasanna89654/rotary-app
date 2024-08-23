import 'package:rotary/domain/entities/news/news_details_entities.dart';

class NewsDetailsModel extends NewsDetails {
  final String? id;
  final String? district;
  final String? club;
  final String? title;
  final String? imageUrl;
  final String? imageName;
  final DateTime? publishDate;
  final String? description;
  final int? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? slug;

  const NewsDetailsModel({
    this.id,
    this.district,
    this.club,
    this.title,
    this.imageUrl,
    this.imageName,
    this.publishDate,
    this.description,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.slug,
  }) : super(
          id: id,
          district: district,
          club: club,
          title: title,
          imageUrl: imageUrl,
          imageName: imageName,
          publishDate: publishDate,
          description: description,
          status: status,
          createdBy: createdBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          slug: slug,
        );

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailsModel(
        id: json['id'] as String?,
        district: json['district'] as String?,
        club: json['club'] as String?,
        title: json['title'] as String?,
        imageUrl: json['image_url'] as String?,
        imageName: json['image_name'] as String?,
        publishDate: DateTime.parse(json['publish_date']),
        description: json['description'] as String?,
        status: json['status'] as int?,
        createdBy: json['created_by'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        slug: json['slug'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'district': district,
        'club': club,
        'title': title,
        'image_url': imageUrl,
        'image_name': imageName,
        'publish_date':
            "${publishDate!.year.toString().padLeft(4, '0')}-${publishDate!.month.toString().padLeft(2, '0')}-${publishDate!.day.toString().padLeft(2, '0')}",
        'description': description,
        'status': status,
        'created_by': createdBy,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'slug': slug,
      };
}

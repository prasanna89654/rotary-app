import 'package:equatable/equatable.dart';

class NewsDetails extends Equatable {
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

  const NewsDetails({
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
  });

  @override
  List<Object?> get props {
    return [
      id,
      district,
      club,
      title,
      imageUrl,
      imageName,
      publishDate,
      description,
      status,
      createdBy,
      createdAt,
      updatedAt,
      slug,
    ];
  }
}

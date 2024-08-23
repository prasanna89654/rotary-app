import 'package:equatable/equatable.dart';

class ResourcesDetail extends Equatable {
  final String? id;
  final String? title;
  final String? shortDesc;
  final String? image;
  final String? year;
  final String? publishDate;
  final String? downloadUrl;
  final int? isDownloadable;
  final int? isExternal;
  final String? externalLink;

  const ResourcesDetail({
    this.id,
    this.title,
    this.shortDesc,
    this.image,
    this.year,
    this.publishDate,
    this.downloadUrl,
    this.isDownloadable,
    this.isExternal,
    this.externalLink,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      shortDesc,
      image,
      year,
      publishDate,
      downloadUrl,
      isDownloadable,
      isExternal,
      externalLink,
    ];
  }
}

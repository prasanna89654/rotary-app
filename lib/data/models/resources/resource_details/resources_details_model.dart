import 'package:rotary/domain/entities/resources/resources_details/resources.dart';

class ResourcesDetailModel extends ResourcesDetail {
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

  const ResourcesDetailModel({
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
  }) : super(
          id: id,
          title: title,
          shortDesc: shortDesc,
          image: image,
          year: year,
          publishDate: publishDate,
          downloadUrl: downloadUrl,
          isDownloadable: isDownloadable,
          isExternal: isExternal,
          externalLink: externalLink,
        );

  factory ResourcesDetailModel.fromJson(Map<String, dynamic> json) =>
      ResourcesDetailModel(
        id: json['id'] as String?,
        title: json['title'] as String?,
        shortDesc: json['short_desc'] as String?,
        image: json['image'] as String?,
        year: json['year'] as String?,
        publishDate: json['publish_date'] as String?,
        downloadUrl: json['download_url'] as String?,
        isDownloadable: json['is_downloadable'] as int?,
        isExternal: json['is_external'] as int?,
        externalLink: json['external_link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'short_desc': shortDesc,
        'image': image,
        'year': year,
        'publish_date': publishDate,
        'download_url': downloadUrl,
        'is_downloadable': isDownloadable,
        'is_external': isExternal,
        'external_link': externalLink,
      };
}

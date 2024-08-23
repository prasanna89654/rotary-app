import 'package:rotary/domain/entities/resources/resources_details/info.dart';

class ResourcesInfoModel extends Info {
  final String? title;
  final int? count;
  final String? image;

  const ResourcesInfoModel({this.title, this.count, this.image})
      : super(
          count: count,
          title: title,
          image: image,
        );

  factory ResourcesInfoModel.fromJson(Map<String, dynamic> json) =>
      ResourcesInfoModel(
        title: json['title'] as String?,
        count: json['count'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'count': count,
        'image': image,
      };
}

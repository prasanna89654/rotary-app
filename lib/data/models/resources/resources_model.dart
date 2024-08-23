import 'package:rotary/domain/entities/resources/resources_entities.dart';

class ResourcesModel extends ResourcesEntities {
  final String? id;
  final String? name;
  final String? image;
  final int? count;
  ResourcesModel({this.id, this.name, this.image, this.count})
      : super(
          count: count,
          id: id,
          image: image,
          name: name,
        );

  factory ResourcesModel.fromJson(Map<String, dynamic> json) {
    return ResourcesModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'count': count,
      };
}

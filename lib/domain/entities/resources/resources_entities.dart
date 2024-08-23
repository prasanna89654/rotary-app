import 'package:equatable/equatable.dart';

class ResourcesEntities extends Equatable {
  final String? id;
  final String? name;
  final String? image;
  final int? count;

  const ResourcesEntities({this.id, this.name, this.image, this.count});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, image, count];
}

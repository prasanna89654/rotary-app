import 'package:equatable/equatable.dart';

class GmlModel extends Equatable {
  final int? id;
  final dynamic name;
  final String? year;
  final String? month;
  final String? description;
  final String? title;
  final String? filename;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GmlModel({
    this.id,
    this.name,
    this.year,
    this.month,
    this.title,
    this.description,
    this.filename,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory GmlModel.fromJson(Map<String, dynamic> json) => GmlModel(
        id: json['id'] as int?,
        name: json['name'] as dynamic,
        year: json['year'] as String?,
        month: json['month'] as String?,
        description: json['description'] as String?,
        title: json['title'] as String?,
        filename: json['filename'] as String?,
        status: json['status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'year': year,
        'month': month,
        'description': description,
        'title': title,
        'filename': filename,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      year,
      month,
      description,
      filename,
      status,
      createdAt,
      updatedAt,
    ];
  }
}

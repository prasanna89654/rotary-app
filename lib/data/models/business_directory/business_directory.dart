import 'package:equatable/equatable.dart';

import 'user.dart';

class BusinessDirectory extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;
  final List<User>? users;

  const BusinessDirectory({this.id, this.name, this.imageUrl, this.users});

  factory BusinessDirectory.fromJson(Map<String, dynamic> json) {
    return BusinessDirectory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
        'users': users?.map((e) => e.toJson()).toList(),
      };

  BusinessDirectory copyWith({
    int? id,
    String? name,
    String? imageUrl,
    List<User>? users,
  }) {
    return BusinessDirectory(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      users: users ?? this.users,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, imageUrl, users];
}

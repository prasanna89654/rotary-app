import 'package:rotary/data/models/login/user.dart';

class ProfileModel {
  User? user;
  String? image;
  List<String>? classifications;
  ProfileModel({this.user, this.image, this.classifications});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      image: json['image'],
      classifications: json['classifications'] != null
          ? List<String>.from(json['classifications'])
          : null,
    );
  }
}

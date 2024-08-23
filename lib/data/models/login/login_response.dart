import 'user.dart';

class LoginResponse {
  User? user;
  String? token;
  String? image;

  LoginResponse({this.user, this.token, this.image});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'token': token,
        'image': image,
      };
}

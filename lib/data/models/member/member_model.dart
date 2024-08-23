import 'package:rotary/domain/entities/member/member.dart';

class MemberModel extends Member {
  final dynamic image;
  final String? name;
  final String? email;
  final String? phone;
  final String? club;
  final String? classification;

  const MemberModel(
      {this.image,
      this.name,
      this.email,
      this.phone,
      this.club,
      this.classification})
      : super(
          image: image,
          name: name,
          email: email,
          phone: phone,
          club: club,
        );

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        image: json['image'] as dynamic,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        club: json['club'] as String?,
        classification: json['classification'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'email': email,
        'phone': phone,
        'club': club,
        'classification': classification,
      };
}

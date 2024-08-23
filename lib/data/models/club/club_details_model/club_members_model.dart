import 'package:rotary/domain/entities/club/club_details/member.dart';

class ClubMembersModel extends ClubMember {
  final String? name;
  final String? phoneNo;
  final String? email;

  const ClubMembersModel({this.name, this.phoneNo, this.email});

  factory ClubMembersModel.fromJson(Map<String, dynamic> json) =>
      ClubMembersModel(
        name: json['name'] as String?,
        phoneNo: json['phone_no'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone_no': phoneNo,
        'email': email,
      };
}

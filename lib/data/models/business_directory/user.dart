import 'package:equatable/equatable.dart';
import 'package:rotary/data/models/business_directory/club_user_model.dart';
import 'package:rotary/data/models/business_directory/club_user_role_model.dart';
import 'package:rotary/data/models/business_directory/user_discrict_committee_model.dart';

import 'user_details.dart';

class User extends Equatable {
  final int? id;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final String? email;
  final String? username;
  final String? status;
  final dynamic emailVerifiedAt;
  final int? otp;
  final int? faliedLoginCount;
  final dynamic lastLoginIp;
  final dynamic lastLoginAt;
  final String? isForget;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic position;
  final String? clubId;
  final dynamic cell;
  final String? memberId;
  final String? admitDate;
  final String? address;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? phoneNo;
  final dynamic cityCountry;
  final String? prefix;
  final String? suffix;
  final String? gender;
  final String? primaryLanguage;
  final String? originalAdmitDate;
  final String? memberType;
  final String? onlineStatus;
  final String? countryCode;
  final String? state;
  final String? province;
  final String? mailingLabel;
  final String? addressLine2;
  final String? addressLine3;
  final String? classification;
  final dynamic donorType;
  final String? bio;
  final UserDetails? userDetails;
  final ClubUser? clubUser;
  final List<UserClubRoles>? userClubRoles;
  final List<UserDistrictCommittee>? userDistrictCommittee;

  const User({
    this.id,
    this.firstname,
    this.middlename,
    this.lastname,
    this.email,
    this.username,
    this.status,
    this.emailVerifiedAt,
    this.otp,
    this.faliedLoginCount,
    this.lastLoginIp,
    this.lastLoginAt,
    this.isForget,
    this.createdAt,
    this.updatedAt,
    this.position,
    this.clubId,
    this.cell,
    this.memberId,
    this.admitDate,
    this.address,
    this.city,
    this.country,
    this.postalCode,
    this.phoneNo,
    this.cityCountry,
    this.prefix,
    this.suffix,
    this.gender,
    this.primaryLanguage,
    this.originalAdmitDate,
    this.memberType,
    this.onlineStatus,
    this.countryCode,
    this.state,
    this.province,
    this.mailingLabel,
    this.addressLine2,
    this.addressLine3,
    this.classification,
    this.donorType,
    this.userDetails,
    this.bio,
    this.clubUser,
    this.userClubRoles,
    this.userDistrictCommittee,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        firstname: json['firstname'] as String?,
        middlename: json['middlename'] as String?,
        lastname: json['lastname'] as String?,
        email: json['email'] as String?,
        username: json['username'] as String?,
        status: json['status'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        otp: json['otp'] as int?,
        faliedLoginCount: json['falied_login_count'] as int?,
        lastLoginIp: json['last_login_ip'] as dynamic,
        lastLoginAt: json['last_login_at'] as dynamic,
        isForget: json['is_forget'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        position: json['position'] as dynamic,
        clubId: json['club_id'] as String?,
        cell: json['cell'] as dynamic,
        memberId: json['member_id'] as String?,
        admitDate: json['admit_date'] as String?,
        address: json['address'] as String?,
        city: json['city'] as String?,
        country: json['country'] as String?,
        postalCode: json['postal_code'] as String?,
        phoneNo: json['phone_no'] as String?,
        cityCountry: json['city_country'] as dynamic,
        prefix: json['prefix'] as String?,
        suffix: json['suffix'] as String?,
        gender: json['gender'] as String?,
        primaryLanguage: json['primary_language'] as String?,
        originalAdmitDate: json['original_admit_date'] as String?,
        memberType: json['member_type'] as String?,
        onlineStatus: json['online_status'] as String?,
        countryCode: json['country_code'] as String?,
        state: json['state'] as String?,
        province: json['province'] as String?,
        mailingLabel: json['mailing_label'] as String?,
        addressLine2: json['address_line_2'] as String?,
        addressLine3: json['address_line_3'] as String?,
        classification: json['classification'] as String?,
        donorType: json['donor_type'] as dynamic,
        bio: json['bio'],
        userDetails: json['user_details'] == null
            ? null
            : UserDetails.fromJson(
                json['user_details'] as Map<String, dynamic>),
        clubUser: json['clubuser'] == null
            ? null
            : ClubUser.fromJson(json['clubuser'] as Map<String, dynamic>),
        userClubRoles: json['userclub_roles'] == null
            ? null
            : List.from(json['userclub_roles'])
                .map((e) => UserClubRoles.fromJson(e))
                .toList(),
        userDistrictCommittee: json['userdistrict_committe'] == null
            ? null
            : List.from(json['userdistrict_committe'])
                .map((e) => UserDistrictCommittee.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'middlename': middlename,
        'lastname': lastname,
        'email': email,
        'username': username,
        'status': status,
        'email_verified_at': emailVerifiedAt,
        'otp': otp,
        'falied_login_count': faliedLoginCount,
        'last_login_ip': lastLoginIp,
        'last_login_at': lastLoginAt,
        'is_forget': isForget,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'position': position,
        'club_id': clubId,
        'cell': cell,
        'member_id': memberId,
        'admit_date': admitDate,
        'address': address,
        'city': city,
        'country': country,
        'postal_code': postalCode,
        'phone_no': phoneNo,
        'city_country': cityCountry,
        'prefix': prefix,
        'suffix': suffix,
        'gender': gender,
        'primary_language': primaryLanguage,
        'original_admit_date': originalAdmitDate,
        'member_type': memberType,
        'online_status': onlineStatus,
        'country_code': countryCode,
        'state': state,
        'province': province,
        'mailing_label': mailingLabel,
        'address_line_2': addressLine2,
        'address_line_3': addressLine3,
        'classification': classification,
        'donor_type': donorType,
        'user_details': userDetails?.toJson(),
      };

  User copyWith({
    int? id,
    String? firstname,
    String? middlename,
    String? lastname,
    String? email,
    String? username,
    String? status,
    dynamic emailVerifiedAt,
    int? otp,
    int? faliedLoginCount,
    dynamic lastLoginIp,
    dynamic lastLoginAt,
    String? isForget,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic position,
    String? clubId,
    dynamic cell,
    String? memberId,
    String? admitDate,
    String? address,
    String? city,
    String? country,
    String? postalCode,
    String? phoneNo,
    dynamic cityCountry,
    String? prefix,
    String? suffix,
    String? gender,
    String? primaryLanguage,
    String? originalAdmitDate,
    String? memberType,
    String? onlineStatus,
    String? countryCode,
    String? state,
    String? province,
    String? mailingLabel,
    String? addressLine2,
    String? addressLine3,
    String? classification,
    dynamic donorType,
    UserDetails? userDetails,
  }) {
    return User(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      middlename: middlename ?? this.middlename,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      username: username ?? this.username,
      status: status ?? this.status,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      otp: otp ?? this.otp,
      faliedLoginCount: faliedLoginCount ?? this.faliedLoginCount,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isForget: isForget ?? this.isForget,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      position: position ?? this.position,
      clubId: clubId ?? this.clubId,
      cell: cell ?? this.cell,
      memberId: memberId ?? this.memberId,
      admitDate: admitDate ?? this.admitDate,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      phoneNo: phoneNo ?? this.phoneNo,
      cityCountry: cityCountry ?? this.cityCountry,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      gender: gender ?? this.gender,
      primaryLanguage: primaryLanguage ?? this.primaryLanguage,
      originalAdmitDate: originalAdmitDate ?? this.originalAdmitDate,
      memberType: memberType ?? this.memberType,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      countryCode: countryCode ?? this.countryCode,
      state: state ?? this.state,
      province: province ?? this.province,
      mailingLabel: mailingLabel ?? this.mailingLabel,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      classification: classification ?? this.classification,
      donorType: donorType ?? this.donorType,
      userDetails: userDetails ?? this.userDetails,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      firstname,
      middlename,
      lastname,
      email,
      username,
      status,
      emailVerifiedAt,
      otp,
      faliedLoginCount,
      lastLoginIp,
      lastLoginAt,
      isForget,
      createdAt,
      updatedAt,
      position,
      clubId,
      cell,
      memberId,
      admitDate,
      address,
      city,
      country,
      postalCode,
      phoneNo,
      cityCountry,
      prefix,
      suffix,
      gender,
      primaryLanguage,
      originalAdmitDate,
      memberType,
      onlineStatus,
      countryCode,
      state,
      province,
      mailingLabel,
      addressLine2,
      addressLine3,
      classification,
      donorType,
      userDetails,
    ];
  }
}

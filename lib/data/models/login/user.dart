class User {
  int? id;
  String? firstname;
  dynamic middlename;
  String? lastname;
  String? email;
  String? username;
  String? status;
  dynamic emailVerifiedAt;
  int? otp;
  int? faliedLoginCount;
  dynamic lastLoginIp;
  dynamic lastLoginAt;
  String? isForget;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic position;
  String? clubId;
  dynamic cell;
  String? memberId;
  String? admitDate;
  String? address;
  String? city;
  dynamic country;
  dynamic postalCode;
  String? phoneNo;
  dynamic cityCountry;
  dynamic prefix;
  dynamic suffix;
  dynamic gender;
  dynamic primaryLanguage;
  dynamic originalAdmitDate;
  dynamic memberType;
  dynamic onlineStatus;
  dynamic countryCode;
  dynamic state;
  dynamic province;
  dynamic mailingLabel;
  dynamic addressLine2;
  dynamic addressLine3;
  String? classification;

  User({
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        firstname: json['firstname'] as String?,
        middlename: json['middlename'] as dynamic,
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
        country: json['country'] as dynamic,
        postalCode: json['postal_code'] as dynamic,
        phoneNo: json['phone_no'] as String?,
        cityCountry: json['city_country'] as dynamic,
        prefix: json['prefix'] as dynamic,
        suffix: json['suffix'] as dynamic,
        gender: json['gender'] as dynamic,
        primaryLanguage: json['primary_language'] as dynamic,
        originalAdmitDate: json['original_admit_date'] as dynamic,
        memberType: json['member_type'] as dynamic,
        onlineStatus: json['online_status'] as dynamic,
        countryCode: json['country_code'] as dynamic,
        state: json['state'] as dynamic,
        province: json['province'] as dynamic,
        mailingLabel: json['mailing_label'] as dynamic,
        addressLine2: json['address_line_2'] as dynamic,
        addressLine3: json['address_line_3'] as dynamic,
        classification: json['classification'] as String?,
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
      };
}

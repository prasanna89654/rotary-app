import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final int? id;
  final int? userId;
  final dynamic phone;
  final dynamic address;
  final String? image;
  final dynamic buisnessName;
  final dynamic buisnessAddress;
  final dynamic buisnessEmail;
  final dynamic buisnessPhone;
  final dynamic buisnessImage;
  final dynamic buisnessUrl;
  final String? buisnessDistrict;
  final String? googleAddress;
  final dynamic buisnessDescription;
  final dynamic buisnessSlogan;
  final dynamic facebook;
  final dynamic instagram;
  final dynamic linkedin;
  final dynamic twitter;
  final dynamic willingToListBusiness;
  final int? featuredBusiness;
  final dynamic features;
  final dynamic businessHours;
  final dynamic gallery;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserDetails({
    this.id,
    this.userId,
    this.phone,
    this.address,
    this.image,
    this.buisnessName,
    this.buisnessAddress,
    this.buisnessEmail,
    this.buisnessPhone,
    this.buisnessImage,
    this.buisnessUrl,
    this.buisnessDistrict,
    this.googleAddress,
    this.buisnessDescription,
    this.buisnessSlogan,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.twitter,
    this.willingToListBusiness,
    this.featuredBusiness,
    this.features,
    this.businessHours,
    this.gallery,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        phone: json['phone'] as dynamic,
        address: json['address'] as dynamic,
        image: json['image'] as String?,
        buisnessName: json['buisness_name'] as dynamic,
        buisnessAddress: json['buisness_address'] as dynamic,
        buisnessEmail: json['buisness_email'] as dynamic,
        buisnessPhone: json['buisness_phone'] as dynamic,
        buisnessImage: json['buisness_image'] as dynamic,
        buisnessUrl: json['buisness_url'] as dynamic,
        buisnessDistrict: json['buisness_district'] as String?,
        googleAddress: json['google_address'] as String?,
        buisnessDescription: json['buisness_description'] as dynamic,
        buisnessSlogan: json['buisness_slogan'] as dynamic,
        facebook: json['facebook'] as dynamic,
        instagram: json['instagram'] as dynamic,
        linkedin: json['linkedin'] as dynamic,
        twitter: json['twitter'] as dynamic,
        willingToListBusiness: json['willingToListBusiness'] as dynamic,
        featuredBusiness: json['featuredBusiness'] as int?,
        features: json['features'] as dynamic,
        businessHours: json['business_hours'] as dynamic,
        gallery: json['gallery'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'phone': phone,
        'address': address,
        'image': image,
        'buisness_name': buisnessName,
        'buisness_address': buisnessAddress,
        'buisness_email': buisnessEmail,
        'buisness_phone': buisnessPhone,
        'buisness_image': buisnessImage,
        'buisness_url': buisnessUrl,
        'buisness_district': buisnessDistrict,
        'google_address': googleAddress,
        'buisness_description': buisnessDescription,
        'buisness_slogan': buisnessSlogan,
        'facebook': facebook,
        'instagram': instagram,
        'linkedin': linkedin,
        'twitter': twitter,
        'willingToListBusiness': willingToListBusiness,
        'featuredBusiness': featuredBusiness,
        'features': features,
        'business_hours': businessHours,
        'gallery': gallery,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  UserDetails copyWith({
    int? id,
    int? userId,
    dynamic phone,
    dynamic address,
    String? image,
    dynamic buisnessName,
    dynamic buisnessAddress,
    dynamic buisnessEmail,
    dynamic buisnessPhone,
    dynamic buisnessImage,
    dynamic buisnessUrl,
    String? buisnessDistrict,
    String? googleAddress,
    dynamic buisnessDescription,
    dynamic buisnessSlogan,
    dynamic facebook,
    dynamic instagram,
    dynamic linkedin,
    dynamic twitter,
    dynamic willingToListBusiness,
    int? featuredBusiness,
    dynamic features,
    dynamic businessHours,
    dynamic gallery,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserDetails(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      image: image ?? this.image,
      buisnessName: buisnessName ?? this.buisnessName,
      buisnessAddress: buisnessAddress ?? this.buisnessAddress,
      buisnessEmail: buisnessEmail ?? this.buisnessEmail,
      buisnessPhone: buisnessPhone ?? this.buisnessPhone,
      buisnessImage: buisnessImage ?? this.buisnessImage,
      buisnessUrl: buisnessUrl ?? this.buisnessUrl,
      buisnessDistrict: buisnessDistrict ?? this.buisnessDistrict,
      googleAddress: googleAddress ?? this.googleAddress,
      buisnessDescription: buisnessDescription ?? this.buisnessDescription,
      buisnessSlogan: buisnessSlogan ?? this.buisnessSlogan,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      linkedin: linkedin ?? this.linkedin,
      twitter: twitter ?? this.twitter,
      willingToListBusiness:
          willingToListBusiness ?? this.willingToListBusiness,
      featuredBusiness: featuredBusiness ?? this.featuredBusiness,
      features: features ?? this.features,
      businessHours: businessHours ?? this.businessHours,
      gallery: gallery ?? this.gallery,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      phone,
      address,
      image,
      buisnessName,
      buisnessAddress,
      buisnessEmail,
      buisnessPhone,
      buisnessImage,
      buisnessUrl,
      buisnessDistrict,
      googleAddress,
      buisnessDescription,
      buisnessSlogan,
      facebook,
      instagram,
      linkedin,
      twitter,
      willingToListBusiness,
      featuredBusiness,
      features,
      businessHours,
      gallery,
      createdAt,
      updatedAt,
    ];
  }
}

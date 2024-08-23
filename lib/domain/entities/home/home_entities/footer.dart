import 'package:equatable/equatable.dart';

class Footer extends Equatable {
  final String? address;
  final String? phone;
  final String? email;
  final String? copyRightText;
  final String? footerTextContactUs;
  final String? brandImage;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;
  final String? youtube;

  const Footer({
    this.address,
    this.phone,
    this.email,
    this.copyRightText,
    this.footerTextContactUs,
    this.brandImage,
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
  });

  factory Footer.fromJson(Map<String, dynamic> json) => Footer(
        address: json['Address'] as String?,
        phone: json['Phone'] as String?,
        email: json['Email'] as String?,
        copyRightText: json['CopyRight Text'] as String?,
        footerTextContactUs: json['Footer Text(Contact Us)'] as String?,
        brandImage: json['Brand Image'] as String?,
        facebook: json['Facebook'] as String?,
        twitter: json['Twitter'] as String?,
        instagram: json['Instagram'] as String?,
        linkedin: json['Linkedin'] as String?,
        youtube: json['Youtube'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Address': address,
        'Phone': phone,
        'Email': email,
        'CopyRight Text': copyRightText,
        'Footer Text(Contact Us)': footerTextContactUs,
        'Brand Image': brandImage,
        'Facebook': facebook,
        'Twitter': twitter,
        'Instagram': instagram,
        'Linkedin': linkedin,
        'Youtube': youtube,
      };

  @override
  List<Object?> get props {
    return [
      address,
      phone,
      email,
      copyRightText,
      footerTextContactUs,
      brandImage,
      facebook,
      twitter,
      instagram,
      linkedin,
      youtube,
    ];
  }
}

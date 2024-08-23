import 'package:equatable/equatable.dart';

class Slider extends Equatable {
  final String? image;
  final String? imageTitle;
  final String? altDescription;

  const Slider({this.image, this.imageTitle, this.altDescription});

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        image: json['image'] as String?,
        imageTitle: json['image_title'] as String?,
        altDescription: json['alt_description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'image_title': imageTitle,
        'alt_description': altDescription,
      };

  @override
  List<Object?> get props => [image, imageTitle, altDescription];
}

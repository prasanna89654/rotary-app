import 'package:equatable/equatable.dart';

class AboutRotatory extends Equatable {
  final String? aboutRotatory;

  const AboutRotatory({this.aboutRotatory});

  factory AboutRotatory.fromJson(Map<String, dynamic> json) => AboutRotatory(
        aboutRotatory: json['About Rotatory'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'About Rotatory': aboutRotatory,
      };

  @override
  List<Object?> get props => [aboutRotatory];
}

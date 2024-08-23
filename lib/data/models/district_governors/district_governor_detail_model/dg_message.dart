import 'package:equatable/equatable.dart';

class DgMessage extends Equatable {
  final String? month;
  final String? year;
  final String? message;

  const DgMessage({this.month, this.year, this.message});

  factory DgMessage.fromJson(Map<String, dynamic> json) => DgMessage(
        month: json['month'] as String?,
        year: json['year'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'month': month,
        'year': year,
        'message': message,
      };

  @override
  List<Object?> get props => [month, year, message];
}

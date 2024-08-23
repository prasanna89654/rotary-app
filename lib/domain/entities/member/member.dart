import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final dynamic image;
  final String? name;
  final String? email;
  final String? phone;
  final String? club;

  const Member({this.image, this.name, this.email, this.phone, this.club});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [image, name, email, phone, club];
}

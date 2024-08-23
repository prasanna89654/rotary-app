import 'package:equatable/equatable.dart';

class ClubMember extends Equatable {
  final String? name;
  final String? phoneNo;
  final String? email;

  const ClubMember({this.name, this.phoneNo, this.email});

  @override
  List<Object?> get props => [name, phoneNo, email];
}

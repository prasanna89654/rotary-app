import 'package:equatable/equatable.dart';

class Info extends Equatable {
  final String? title;
  final int? count;
  final String? image;

  const Info({this.title, this.count, this.image});

  @override
  List<Object?> get props => [title, count, image];
}

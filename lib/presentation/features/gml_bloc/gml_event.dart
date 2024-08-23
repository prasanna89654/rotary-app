part of 'gml_bloc.dart';

abstract class GmlEvent extends Equatable {
  const GmlEvent();

  @override
  List<Object> get props => [];
}

class GetAllGmlEvent extends GmlEvent {}

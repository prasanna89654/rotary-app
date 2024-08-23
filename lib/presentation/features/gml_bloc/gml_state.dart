part of 'gml_bloc.dart';

abstract class GmlState extends Equatable {
  const GmlState();

  @override
  List<Object> get props => [];
}

class GmlInitial extends GmlState {}

class GmlLoaded extends GmlState {
  final List<GmlModel> gmlModel;

  GmlLoaded(this.gmlModel);

  @override
  List<Object> get props => [gmlModel];
}

class GmlError extends GmlState {
  final String errorMessage;

  GmlError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

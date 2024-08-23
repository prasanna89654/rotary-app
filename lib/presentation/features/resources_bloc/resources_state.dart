part of 'resources_bloc.dart';

abstract class ResourcesState extends Equatable {
  const ResourcesState();

  @override
  List<Object> get props => [];
}

class ResourcesInitial extends ResourcesState {}

class ResourcesLoadingState extends ResourcesState {}

class ResourcesLoadedState extends ResourcesState {
  final List<ResourcesModel> resourcesList;

  ResourcesLoadedState(this.resourcesList);
}

class ResourcesDetailLoadedState extends ResourcesState {
  final ResourcesDetailResponseModel? resourcesDetail;
  final ResourceDescriptionModel? resourceDescription;
  final List<ResourcesModel>? resourcesList;

  ResourcesDetailLoadedState(
      this.resourcesList, this.resourcesDetail, this.resourceDescription);
}

class ResourcesErrorState extends ResourcesState {
  final String error;

  ResourcesErrorState(this.error);
}

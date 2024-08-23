part of 'resources_bloc.dart';

abstract class ResourcesEvent extends Equatable {
  const ResourcesEvent();

  @override
  List<Object> get props => [];
}

class GetAllResourcesEvent extends ResourcesEvent {}

class GetResourcesDetailsEvent extends ResourcesEvent {
  final String id;

  GetResourcesDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetResourceDescriptionEvent extends ResourcesEvent {
  final String id;

  GetResourceDescriptionEvent({required this.id});

  @override
  List<Object> get props => [id];
}

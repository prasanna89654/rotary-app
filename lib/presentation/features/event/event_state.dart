part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final EventDetailsModel eventDetailsModel;
  EventLoaded(this.eventDetailsModel);
}

class EventError extends EventState {
  final String error;

  EventError(this.error);

  @override
  List<Object> get props => [error];
}

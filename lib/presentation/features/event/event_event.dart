part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetEventDetails extends EventEvent {
  final String eventId;

  GetEventDetails(this.eventId);

  @override
  List<Object> get props => [eventId];
}

part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<CalendarEventModel> calendarEventModels;

  const CalendarLoaded(this.calendarEventModels);

  @override
  List<Object> get props => [calendarEventModels];
}

class CalendarError extends CalendarState {
  final String message;

  CalendarError(this.message);

  @override
  List<Object> get props => [message];
}

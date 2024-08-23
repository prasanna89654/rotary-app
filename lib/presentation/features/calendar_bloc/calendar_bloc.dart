import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/calendar_event/calendar_event_model.dart';
import 'package:rotary/domain/usecases/calendar_usecase/get_calendar_all_events_usecase.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  GetCalendarAllEventUseCase getCalendarAllEventUseCase;
  CalendarBloc(this.getCalendarAllEventUseCase) : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) async {
      if (event is LoadCalendarAllEvent) {
        emit(CalendarLoading());
        emit(await _mapCalendarAllEventToState(
            await getCalendarAllEventUseCase.call(NoParams())));
      }
    });
  }
  Future<CalendarState> _mapCalendarAllEventToState(
      Either<Failure, List<CalendarEventModel>> either) async {
    return either.fold(
        (l) => CalendarError(l.failureMessage), (r) => CalendarLoaded(r));
  }
}

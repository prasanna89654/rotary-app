import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary/domain/usecases/event_usecase/get_event_details_usecase.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/event/event_details_model/event_details_model.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  GetEventDetailsUsecase getEventDetailsUsecase;
  EventBloc(this.getEventDetailsUsecase) : super(EventInitial()) {
    on<EventEvent>((event, emit) async {
      if (event is GetEventDetails) {
        emit(EventLoading());
        emit(await loadEventDetails(
            await getEventDetailsUsecase.call(event.eventId)));
      }
    });
  }
  Future<EventState> loadEventDetails(
      Either<Failure, EventDetailsModel> either) async {
    return either.fold(
        (l) => EventError(l.failureMessage), (r) => EventLoaded(r));
  }
}

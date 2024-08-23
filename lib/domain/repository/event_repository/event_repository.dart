import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/event/event_details_model/event_details_model.dart';
import 'package:rotary/data/models/event/event_response_model.dart';

abstract class EventRepository {
  Future<Either<Failure, EventResponseModel>> getUpcommingEvent();
  Future<Either<Failure, EventDetailsModel>> getEventDetails(String id);
  Future<Either<Failure, EventResponseModel>> getCalendarAllEvents();
}

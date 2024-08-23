import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/calendar_event/calendar_event_model.dart';

abstract class CalendarEventRepository {
  Future<Either<Failure, List<CalendarEventModel>>> loadCalendarAllEvent();
}

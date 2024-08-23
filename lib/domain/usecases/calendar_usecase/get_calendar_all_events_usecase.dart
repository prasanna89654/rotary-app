import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/calendar_event/calendar_event_model.dart';
import 'package:rotary/domain/repository/calendar_event_repository.dart';

import '../../../core/use_cases.dart/use_cases.dart';

abstract class GetCalendarAllEventUseCase
    extends UseCases<Either<Failure, List<CalendarEventModel>>, NoParams> {}

class GetCalendarAllEventUseCaseImpl extends GetCalendarAllEventUseCase {
  final CalendarEventRepository _calendarEventRepository;
  GetCalendarAllEventUseCaseImpl(this._calendarEventRepository);
  @override
  Future<Either<Failure, List<CalendarEventModel>>> call(
      NoParams params) async {
    return await _calendarEventRepository.loadCalendarAllEvent();
  }
}

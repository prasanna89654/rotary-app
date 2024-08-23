import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/event/event_response_model.dart';
import 'package:rotary/domain/repository/event_repository/event_repository.dart';

abstract class GetUpcommingEventUseCase
    implements UseCases<Either<Failure, EventResponseModel>, NoParams> {}

class GetUpcommingEventUseCaseImpl implements GetUpcommingEventUseCase {
  EventRepository eventRepository;
  GetUpcommingEventUseCaseImpl({required this.eventRepository});
  @override
  Future<Either<Failure, EventResponseModel>> call(NoParams params) {
    return eventRepository.getUpcommingEvent();
  }
}

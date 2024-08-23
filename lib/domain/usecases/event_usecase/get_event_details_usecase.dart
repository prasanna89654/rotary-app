import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/event_repository/event_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/use_cases.dart/use_cases.dart';
import '../../../data/models/event/event_details_model/event_details_model.dart';

abstract class GetEventDetailsUsecase
    implements UseCases<Either<Failure, EventDetailsModel>, String> {}

class GetEventDetailsUsecaseImpl implements GetEventDetailsUsecase {
  EventRepository eventRepository;
  GetEventDetailsUsecaseImpl(this.eventRepository);
  @override
  Future<Either<Failure, EventDetailsModel>> call(String params) async {
    return await eventRepository.getEventDetails(params);
  }
}

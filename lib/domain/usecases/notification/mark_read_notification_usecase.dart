import 'package:dartz/dartz.dart';
import 'package:rotary/data/models/notification/notification_response.dart';
import 'package:rotary/domain/repository/notification_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/use_cases.dart/use_cases.dart';

abstract class MarkReadNotificationUseCase
    implements UseCases<Either<Failure, NotificationResponseModel>, String> {}

class MarkReadNotificationUseCaseImpl implements MarkReadNotificationUseCase {
  final NotificationRepository notificationRepository;
  MarkReadNotificationUseCaseImpl(this.notificationRepository);
  @override
  Future<Either<Failure, NotificationResponseModel>> call(
      String notificationId) {
    return notificationRepository.markRead(notificationId);
  }
}

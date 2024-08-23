import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/notification_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/use_cases.dart/use_cases.dart';

abstract class MarkReadAllNotificationUseCase
    implements UseCases<Either<Failure, bool>, NoParams> {}

class MarkReadAllNotificationUseCaseImpl
    implements MarkReadAllNotificationUseCase {
  final NotificationRepository notificationRepository;
  MarkReadAllNotificationUseCaseImpl(this.notificationRepository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return notificationRepository.markAllRead();
  }
}

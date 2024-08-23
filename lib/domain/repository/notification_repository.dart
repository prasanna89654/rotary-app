import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/notification/notification_response.dart';

abstract class NotificationRepository {
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  Future<Either<Failure, NotificationResponseModel>> markRead(
    String notificationId,
  );
  Future<Either<Failure, bool>> markAllRead();
}

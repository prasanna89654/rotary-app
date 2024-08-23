import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/data_sources/notification/notification_remote_data_sources.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/data/models/notification/notification_response.dart';
import 'package:rotary/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseMessaging firebaseMessaging;
  final UserLocalDataSources userLocalDataSources;
  final NotificationRemoteDataSources notificationRemoteDataSources;
  NotificationRepositoryImpl(
      {required this.firebaseMessaging,
      required this.userLocalDataSources,
      required this.notificationRemoteDataSources});
  @override
  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  Future<Either<Failure, bool>> markAllRead() async {
    try {
      final token = await userLocalDataSources.getUserToken();
      await notificationRemoteDataSources.markAllRead(token);
      return Right(true);
    } catch (e) {
      return Left(parseFailure(e));
    }
  }

  @override
  Future<Either<Failure, NotificationResponseModel>> markRead(
      String notificationId) async {
    try {
      final token = await userLocalDataSources.getUserToken();
      final result =
          await notificationRemoteDataSources.markRead(token, notificationId);
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rotary/core/network/network_utils.dart';

import '../../../core/error/exceptions.dart';
import '../../models/notification/notification_response.dart';

abstract class NotificationRemoteDataSources {
  Future<NotificationResponseModel> markRead(
    String token,
    String notificationId,
  );
  Future<bool> markAllRead(String token);
}

class NotificationRemoteDataSourcesImpl
    implements NotificationRemoteDataSources {
  final NetworkUtil networkUtil;
  NotificationRemoteDataSourcesImpl({required this.networkUtil});
  @override
  Future<bool> markAllRead(String token) async {
    try {
      await networkUtil.get(
          "https://rotarydistrict3292.org.np/public/api/notification/mark-all-read",
          token: token);
      return true;
    } catch (e) {
      throw throwException(e);
    }
  }

  @override
  Future<NotificationResponseModel> markRead(
      String token, String notificationId) async {
    try {
      log("id: $notificationId");
      log("token: $token");
      final Response response = await networkUtil.postQueryParams(
        "https://rotarydistrict3292.org.np/public/api/notification/mark-read",
        token: token,
        params: {"id": notificationId},
      );
      NotificationResponseModel notificationResponseModel =
          NotificationResponseModel.fromJson(response.data['notifications']);
      return notificationResponseModel;
    } catch (e) {
      throw throwException(e);
    }
  }
}

import 'package:flutter/material.dart';

class AppConstant {
  static const double DefaultPadding = 8;
  static const BorderRadius DefaultRadius = const BorderRadius.all(
    Radius.circular(8),
  );

  /// shared preferences
  static const String prefLoggedIn = "isLoggedIn";
  static const String prefToken = "token";
  static const String prefUserId = "userId";
  static const String prefUserName = "userName";
  static const String prefUserImage = "userImage";

  /// notification
  static const String EVENT_TOPIC = "events";
}

import 'package:rotary/data/models/notification/notifications_model.dart';

class NotificationResponseModel {
  int? unreadCount;
  List<NotificationModel>? notifications;
  NotificationResponseModel({this.unreadCount, this.notifications});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unread_count'];
    if (json['notifications'] != null) {
      notifications = <NotificationModel>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unread_count'] = this.unreadCount;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'package:rotary/data/models/notification/notification_data_model.dart';

class NotificationModel {
  NotificationDataModel? notification;
  String? nId;
  String? readAt;
  String? createdAt;

  NotificationModel({this.notification, this.nId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new NotificationDataModel.fromJson(json['notification'])
        : null;
    nId = json['n_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    data['n_id'] = this.nId;
    return data;
  }
}

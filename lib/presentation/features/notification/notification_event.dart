part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class MarkReadEvent extends NotificationEvent {
  final String notificationId;
  MarkReadEvent(this.notificationId);
}

class MarkAllReadEvent extends NotificationEvent {}

class CheckTokenExist extends NotificationEvent {}

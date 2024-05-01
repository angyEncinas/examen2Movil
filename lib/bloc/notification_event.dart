import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationEvent {}

class InitializeAppEvent extends NotificationEvent {}

class RequestPermissionEvent extends NotificationEvent {}

class GetMessageTokenEvent extends NotificationEvent {}

class OnMessageEvent extends NotificationEvent {
  final RemoteMessage message;

  OnMessageEvent(this.message);
}

class OnBackgroundMessageEvent extends NotificationEvent {
  final RemoteMessage message;

  OnBackgroundMessageEvent(this.message);
}
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationInitializedState extends NotificationState {}

class NotificationPermissionGrantedState extends NotificationState {}

class NotificationTokenObtainedState extends NotificationState {
  final String token;

  NotificationTokenObtainedState(this.token);
}

class NotificationMessageReceivedState extends NotificationState {
  final RemoteMessage message;

  NotificationMessageReceivedState(this.message);
}

class NotificationBackgroundMessageReceivedState extends NotificationState {
  final RemoteMessagemessage;

  NotificationBackgroundMessageReceivedState(this.RemoteMessagemessage);
}
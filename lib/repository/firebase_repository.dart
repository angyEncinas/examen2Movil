import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification/firebase_options.dart';

class FirebaseRepository {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseRepository() : _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('Notification permission granted: ${settings.authorizationStatus}');
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  void onBackgroundMessage(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void onMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification!= null) {
      print('Message also contained a notification ${message.notification}');
    }
  }
}
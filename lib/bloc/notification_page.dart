import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/bloc/notification_bloc.dart';
import 'package:flutter_notification/bloc/notification_event.dart';
import 'package:flutter_notification/bloc/notification_state.dart';
import 'package:flutter_notification/repository/firebase_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();
    _notificationBloc = NotificationBloc(FirebaseRepository());
    _notificationBloc.add(InitializeAppEvent());
    _notificationBloc.add(RequestPermissionEvent());
    _notificationBloc.add(GetMessageTokenEvent());
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _notificationBloc.add(OnMessageEvent(message));
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // Agrega el evento al bloc
    _notificationBloc.add(OnMessageEvent(message));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<NotificationState>(
          stream: _notificationBloc.stream,
          initialData: NotificationInitialState(),
          builder: (context, snapshot) {
            if (snapshot.data is NotificationTokenObtainedState) {
              final token = (snapshot.data as NotificationTokenObtainedState).token;
              print('Message data: $token');
            }
            return const Text('Hello World!');
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notificationBloc.close();
    super.dispose();
  }
}
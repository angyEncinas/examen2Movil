import 'package:bloc/bloc.dart';
import 'package:flutter_notification/bloc/notification_event.dart';
import 'package:flutter_notification/bloc/notification_state.dart';
import 'package:flutter_notification/repository/firebase_repository.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirebaseRepository _firebaseRepository;

  NotificationBloc(this._firebaseRepository) : super(NotificationInitialState());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is InitializeAppEvent) {
      await _firebaseRepository.initializeApp();
      yield NotificationInitializedState();
    } else if (event is RequestPermissionEvent) {
      await _firebaseRepository.requestNotificationPermission();
      yield NotificationPermissionGrantedState();
    } else if (event is GetMessageTokenEvent) {
      final token = await _firebaseRepository.getToken();
      yield NotificationTokenObtainedState(token!);
    } else if (event is OnMessageEvent) {
      _firebaseRepository.onMessage(event.message);
      yield NotificationMessageReceivedState(event.message);
    } else if (event is OnBackgroundMessageEvent) {
      _firebaseRepository.onBackgroundMessage(event.message);
      yield NotificationBackgroundMessageReceivedState(event.message);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_notification/bloc/notification_page.dart';

void main() {
  runApp(const MainPage());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
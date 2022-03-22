import 'package:chat/scr/scr.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: _Router.router,
      title: 'Chat',
    );
  }
}

class _Router {
  static Map<String, Widget Function(BuildContext)> router = {
    'home': (_) => Home(),
    'login': (_) => Login(),
    'newUser': (_) => NewUser(),
    'chatPrivado': (_) => ChatPrivado(),
    'chatList': (_) => ChatList()
  };
}

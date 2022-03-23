
import 'package:chat/scr/scr.dart';
import 'package:flutter/material.dart';

class StaticRouter {
  static Map<String, Widget Function(BuildContext)> router = {
    'home': (_) => Home(),
    'login': (_) => Login(),
    'newUser': (_) => NewUser(),
    'chatPrivado': (_) => ChatPrivado(),
    'chatList': (_) => ChatList()
  };
}
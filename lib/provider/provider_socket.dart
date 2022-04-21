import 'package:chat/statcs.dart/env.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ProviderSocet extends ChangeNotifier {
  bool _estadoConect = false;

  ProviderSocet() {
    estadoSocket();
  }

  bool get estadoLine => _estadoConect;
  set estadoLine(bool estado) {
    _estadoConect = estado;
    notifyListeners();
  }

  void estadoSocket() {
    print('init soket');

    io.Socket socket = io.io(
      Env.uriSocket,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          //.disableAutoConnect() // for Flutter or Dart VM
          .build(),
    );

    socket.onConnect(
      (_) {
        estadoLine = true;
        print('conectadooo ');
        return;
      },
    );

    socket.onDisconnect((_) => {estadoLine = false});
  }
}

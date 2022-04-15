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
    io.Socket socket = io.io('http://localhost:3000');

    socket.onConnect(
      (_) {
        estadoLine = true;
        print('conectadooo ');
        return;
      },
    );

    socket.onDisconnect((_) => estadoLine = false);
  }
}

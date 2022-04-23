import 'package:chat/provider/provider_api.dart';
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
      //{
      //  'transports':['websocket'],
      //  'autoConnect':true,
      //  'forceNew':true,
      //  'extraHeaders':{
      //    'x-token':''
      //  }

      //}
      io.OptionBuilder()
          .enableForceNew()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'x-token': ProviderApi.tokenPuro})
          .build(),
    );

    socket.onConnect(
      (_) {
        estadoLine = true;
        print('conectadooo ');

        return;
      },
    );
    socket.emit('jwt', {ProviderApi.tokenPuro});
    socket.onDisconnect((_) => {estadoLine = false});
  }
}

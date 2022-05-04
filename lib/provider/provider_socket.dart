import 'package:chat/provider/provider_api.dart';
import 'package:chat/statcs.dart/env.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

class ProviderSocket extends ChangeNotifier {
  bool _estadoConect = false;
  bool _actualizar = false; //lo usaremos para actualizar

  late io.Socket socket;
  ProviderSocket() {
    //estadoSocket();
  }

  set actualizar(bool value) {
    _actualizar = value;
    notifyListeners();
  }

  bool get actualizar => _actualizar;

  bool get estadoLine => _estadoConect;
  set estadoLine(bool estado) {
    _estadoConect = estado;
    notifyListeners();
  }

  conectarSocket() {
    try {
      print('init soket');

      socket = io.io(
        Env.uriSocket,
        //{
        //  'transports':['websocket'],
        //  'autoConnect':true,
        //  'forceNew':true,
        //  'extraHeaders':{
        //    'x-token':''
        //  }

        //}
        io.OptionBuilder().enableForceNew().setTransports(['websocket'])
            //.enableAutoConnect()
            .setExtraHeaders({'x-token': ProviderApi.tokenPuro}).build(),
      );

      socket.onConnect(
        (_) {
          estadoLine = true;
          print('conectadooo ');
          socket.emit('online', true);
          socket.on('actualizar', (data) {
            print('info para actualizar estados automaticos');
            actualizar = true;
          });
          // return;
        },
      );
      socket.onDisconnect((_) {
        //se ejecuta cuando el servidor te desconecta o se desconecta
        print('desconectando por token');
        estadoLine = false;
      });
    } catch (e) {
      print('no hay conexion');
      return;
    }
  }

  onOffSocket(bool conectar) {
    if (conectar == false) {
      print('en if conectar false');
      socket.emit('online', false);
      socket.disconnect();
      return;
    } else {
      socket.connect();
    }
  }
}

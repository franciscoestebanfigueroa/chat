import 'dart:io';

import 'package:chat/models/model_chat.dart';
import 'package:chat/models/model_historial.dart';
import 'package:http/http.dart';

Future<List<MensajesChat>> historial(String de, String token) async {
  //print('historial token $token');
  String dir = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  Uri uriMensajes = Uri.parse('http://$dir:3000/api/mensajes/$de');

  Response historial = await get(uriMensajes,
      headers: {'Content-Type': 'application/json', 'x-token': token});
  final recuperoMensajes = historialFromMap(historial.body);
  List<MensajesChat> listadoMensajes = [];
  for (var item in recuperoMensajes.ultimos30) {
    MensajesChat data =
        MensajesChat(data: item.data, de: item.de, para: item.para);
    listadoMensajes.add(data);

    print(item.data);
  }
  return listadoMensajes;
}

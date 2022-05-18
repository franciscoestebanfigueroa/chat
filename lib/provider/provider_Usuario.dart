import 'package:chat/models/model_chat.dart';
import 'package:chat/models/model_listado.dart';
import 'package:chat/models/ususrio.dart';
import 'package:flutter/foundation.dart';

class ProviderDataChat extends ChangeNotifier {
  late Usuario _usuario;
  List<MensajesChat> _listaMensajes = [];
  List<MensajesChat> get listaMensajes => _listaMensajes;
  set listaMensajes(List<MensajesChat> x) {
    _listaMensajes = x;
    notifyListeners();
  }

  void insertarMensajes(dynamic mensaje) {
    _listaMensajes.insert(
        0,
        MensajesChat(
            data: mensaje['data'], de: mensaje['de'], para: mensaje['para']));
    notifyListeners();
  }

  bool _botonEnviar = false;

  Usuario get dataChat => _usuario;

  set botonEnviar(bool botonEnviar) {
    _botonEnviar = botonEnviar;
    notifyListeners();
  }

  bool get botonEnviar => _botonEnviar;

  set dataChat(Usuario usr) {
    _usuario = usr;
    notifyListeners();
  }

  addTxt(String chat, String id) {
    // this._usuario.txt.insert(0, chat);
    // this._usuario.id.insert(0, id);
    notifyListeners();
  }

  deleteTxt(int id) {
    print(id);
    // this._usuario.txt.removeRange(id, id + 1);
    // this._usuario.id.removeRange(id, id + 1);
    notifyListeners();
  }
}

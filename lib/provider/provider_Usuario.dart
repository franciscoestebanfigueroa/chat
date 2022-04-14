import 'package:chat/models/ususrio.dart';
import 'package:flutter/foundation.dart';

class ProviderDataChat extends ChangeNotifier {
  late Usuario _usuario;
  bool _botonEnviar = false;
  ProviderDataChat(Usuario usr) {
    _usuario = usr;
  }

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
    this._usuario.txt.insert(0, chat);
    this._usuario.id.insert(0, id);
    notifyListeners();
  }

  deleteTxt(int id) {
    print(id);
    this._usuario.txt.removeRange(id, id + 1);
    this._usuario.id.removeRange(id, id + 1);
    notifyListeners();
  }
}

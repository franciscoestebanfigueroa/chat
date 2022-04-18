import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/model_response_login.dart';
import 'package:chat/models/ususrio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderApi extends ChangeNotifier {
  final _storage = FlutterSecureStorage();
  late Usuario usuario; //
  bool _estadoBoton = true;

//metodos estaticos dentro de la clase, no los voy a tener que instanciar
//serian getter

  static Future<String> getToken() async {
    final _storage =
        FlutterSecureStorage(); //como es estatico no puedo acceder afuera, tengo que instanciar nuevamente
    final token = await _storage.read(key: 'token');
    return token ?? '';
  }

  static Future logout() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  set estadoBoton(bool estadoBoton) {
    _estadoBoton = estadoBoton;
    notifyListeners();
  }

  bool get estadoBoton => _estadoBoton;

  Future<bool> login(String correo, String pass) async {
    Map<String, String> data = {"email": correo, 'password': pass};
    //final data = {"email": "pancho@pancho.com", 'password': '123456'};
    Uri uri = Uri.parse('http://localhost:3000/api/login/');

    Uri urii = Uri.http('10.0.2.2:3000', '/api/login/');

    estadoBoton = false;
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.post(
      urii,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final user = loginResponseFromJson(response.body);
      usuario = user.usuario;
      print(usuario.nombre);
      print(usuario.email);
      print(usuario.uid);

      guardarToken(user.newToken);

      estadoBoton = true;
      return true;
    } else {
      print('error de credenciales');
      usuario = Usuario(nombre: '', email: '', online: false, uid: '0');
      estadoBoton = true;
      return false;
    }
  }

  Future guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
    String? value = await _storage.read(key: 'token');
    print('token guardado $value');
  }

  Future eliminarToken() async {
    await _storage.delete(key: 'token');
  }
}

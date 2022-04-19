import 'dart:convert';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/model_response_login.dart';
import 'package:chat/models/ususrio.dart';
import 'package:chat/statcs.dart/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderApi extends ChangeNotifier {
  //final _storage = FlutterSecureStorage();
  late Usuario usuario; //
  bool _estadoBoton = true;

//metodos estaticos dentro de la clase, no los voy a tener que instanciar
//serian getter

//  static Future<String> getToken() async {
//    final _storage =
//        FlutterSecureStorage(); //como es estatico no puedo acceder afuera, tengo que instanciar nuevamente
//    final token = await _storage.read(key: 'token');
//    return token ?? '';
//  }

  //static Future logout() async {
  //  final _storage = FlutterSecureStorage();
  //  await _storage.delete(key: 'token');
  //}

  set estadoBoton(bool estadoBoton) {
    _estadoBoton = estadoBoton;
    notifyListeners();
  }

  bool get estadoBoton => _estadoBoton;

  Future<bool> login(String correo, String pass) async {
    Map<String, String> data = {"email": correo, 'password': pass};
    //final data = {"email": "pancho@pancho.com", 'password': '123456'};

    estadoBoton = false;
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.post(
      Env.uriLocal,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // print(response.body);
      final user = loginResponseFromJson(response.body);
      usuario = user.usuario;
      print(usuario.nombre);
      print(usuario.email);
      print(usuario.uid);

//      guardarToken(user.newToken);

      estadoBoton = true;
      return true;
    } else {
      print('error de credenciales');
      usuario = Usuario(nombre: '', email: '', online: false, uid: '0');
      estadoBoton = true;
      return false;
    }
  }
//
  // Future guardarToken(String token) async {
  //   await _storage.write(key: 'token', value: token);
  //   String? value = await _storage.read(key: 'token');
  //   print('token guardado $value');
  // }
//
  // Future eliminarToken() async {
  //   await _storage.delete(key: 'token');
  // }

  Future newUser(String nombre, String correo, String password) async {
    estadoBoton = false;
    await Future.delayed(const Duration(seconds: 1));

    final data = {'nombre': nombre, 'email': correo, 'password': password};
    http.Response response = await http.post(
      Env.uriLocalNew,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final user = loginResponseFromJson(response.body);
      print(user.usuario.nombre);
      print(user.newToken);
      estadoBoton = true;
      //guardarToken(user.newToken);
      return true;
    } else {
      estadoBoton = true;
      print(response.statusCode);
      final error = jsonDecode(response.body);
      print(error);

      return error['msg'];
    }
  }
}
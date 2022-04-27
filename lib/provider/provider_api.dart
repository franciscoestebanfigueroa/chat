import 'dart:convert';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/model_response_login.dart';
import 'package:chat/models/ususrio.dart';
import 'package:chat/statcs.dart/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderApi extends ChangeNotifier {
  //final _storage = FlutterSecureStorage();
   Usuario usuario=Usuario(nombre: '', email: '', online: false, uid: ''); //
  bool _estadoBoton = true;
  static String _tokenPuro = '';
  List<Usuario> listado=[];  
  borrarListado(){
listado.clear();
    notifyListeners();
  }    
static String get tokenPuro=>_tokenPuro;

  static set tokenPuro(String token) {
    _tokenPuro = token;
    
    print(' token puro $_tokenPuro');
    
    
  }
  
  //static String get token=>_tokenPuro;

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

    try {
      estadoBoton = false;
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.post(
      Env.uriLogin,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // print(response.body);
     tokenPuro='';
      LoginResponse user = loginResponseFromJson(response.body);
      usuario = user.usuario;
      print(usuario.nombre);
      //  print(usuario.email);
      //  print(usuario.uid);
      print(user.newToken);
      _tokenPuro = user.newToken;

      //guardarToken(user.newToken);

      estadoBoton = true;
      return true;
    } else {
      print('error de credenciales');
      usuario = Usuario(nombre: '', email: '', online: false, uid: '0');
      estadoBoton = true;
      return false;
    }
    } catch (e) {
      print('no hay conexion');
      estadoBoton=true;
      return false;
    }
  }

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
      Env.uriNewUser,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final user = loginResponseFromJson(response.body);
      print(user.usuario.nombre);
      print(user.newToken);
      tokenPuro = user.newToken;
      estadoBoton = true;
      // guardarToken(user.newToken);
      return true;
    } else {
      estadoBoton = true;
      print(response.statusCode);
      final error = jsonDecode(response.body);
      print(error);

      return error['msg'];
    }
  }

  Future<bool> isItokenValidate() async {
    await Future.delayed(Duration(seconds: 3));
    return false;

    //  String? token = await _storage.read(key: 'token');
    //  if (token == null) {
    //    return false;
    //   }
    //   http.Response response = await http.get(
    //     Env.uriLocalreNew,
    //     headers: {'Content-Type': 'application/json', 'x-token': token},
    //   );
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   print(response.body);
    //   final responsebody = loginResponseFromJson(response.body);

    // await guardarToken(responsebody.newToken);

    return true;
    // } else {
    //   return false;
    //   }
  }

  Future<bool> listadoUser() async {
    http.Response response = await http.get(
      Env.uriListado,
      headers: {'Content-Type': 'application/json', 'x-token': tokenPuro},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      //print(response.body);
      final responsebody = jsonDecode(response.body);
      final x=responsebody['usuarios'];
    
      

      for (var item in x) {
        
        Usuario a=Usuario.fromJson(item);
         listado.add(a);
      }
      
       
       print(listado.map((e) => e.email));       
    
    notifyListeners();
    return true;
    }
    else{
      return false;
    }
    
  }
}

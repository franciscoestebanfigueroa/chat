import 'dart:convert';

import 'package:chat/models/model_response_login.dart';
import 'package:chat/models/ususrio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderApi extends ChangeNotifier {
  late Usuario usuario;

  Future login(String correo, String pass) async {
    //Map<String, String> data = {"email": correo, 'password': pass};
    final data = {"email": "pancho@pancho.com", 'password': '123456'};
    // Uri uri = Uri.parse('http://10.0.2.2:3000/api/login');

    Uri urii = Uri.http('10.0.2.2:3000', '/api/login/');
    final response = await http.post(
      urii,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    //print(response.body);

    if (response.statusCode == 200) {
      final user = loginResponseFromJson(response.body);
      usuario = user.usuario;
    }

    print(usuario.nombre);
    print(usuario.email);
    print(usuario.uid);
  }
}

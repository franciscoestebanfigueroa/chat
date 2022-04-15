// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/ususrio.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.mge,
    required this.usuario,
    required this.newToken,
  });

  bool ok;
  String mge;
  Usuario usuario;
  String newToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        mge: json["mge"],
        usuario: Usuario.fromJson(json["usuario"]),
        newToken: json["newToken"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mge": mge,
        "usuario": usuario.toJson(),
        "newToken": newToken,
      };
}

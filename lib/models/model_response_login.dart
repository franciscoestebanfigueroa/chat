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
    required this.msg,
    required this.usuario,
    required this.newToken,
  });

  bool ok;
  String msg;
  Usuario usuario;
  String newToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msg: json["msg"],
        usuario: Usuario.fromJson(json["usuario"]),
        newToken: json["newToken"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mge": msg,
        "usuario": usuario.toJson(),
        "newToken": newToken,
      };
}

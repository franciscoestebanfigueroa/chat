// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/ususrio.dart';

listadoChat listadoChatFromJson(String str) =>
    listadoChat.fromJson(json.decode(str));

String listadoChatToJson(listadoChat data) => json.encode(data.toJson());

class listadoChat {
  listadoChat({
    required this.ok,
    required this.msg,
    required this.usuarios,
  });

  bool ok;
  String msg;
  List<Usuario> usuarios;

  factory listadoChat.fromJson(Map<String, dynamic> json) => listadoChat(
        ok: json["ok"],
        msg: json["msg"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}

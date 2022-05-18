// To parse this JSON data, do
//
//     final historial = historialFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Historial historialFromMap(String str) => Historial.fromMap(json.decode(str));

String historialToMap(Historial data) => json.encode(data.toMap());

class Historial {
  Historial({
    required this.de,
    required this.para,
    required this.mensaje,
    required this.ultimos30,
  });

  final String de;
  final String para;
  final String mensaje;
  final List<Ultimos30> ultimos30;

  factory Historial.fromMap(Map<String, dynamic> json) => Historial(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        ultimos30: List<Ultimos30>.from(
            json["ultimos30"].map((x) => Ultimos30.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "ultimos30": List<dynamic>.from(ultimos30.map((x) => x.toMap())),
      };
}

class Ultimos30 {
  Ultimos30({
    required this.de,
    required this.para,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  final String de;
  final String para;
  final String data;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Ultimos30.fromMap(Map<String, dynamic> json) => Ultimos30(
        de: json["de"],
        para: json["para"],
        data: json["data"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "de": de,
        "para": para,
        "data": data,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chatAppFlutter/models/usuario.dart';

UsuariosResponse usuariosResponseFromJson(String str) =>
    UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) =>
    json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    this.codError,
    this.descError,
    this.objetoRespuesta,
  });

  int codError;
  String descError;
  ObjetoRespuesta objetoRespuesta;

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(
        codError: json["codError"],
        descError: json["descError"],
        objetoRespuesta: ObjetoRespuesta.fromJson(json["objetoRespuesta"]),
      );

  Map<String, dynamic> toJson() => {
        "codError": codError,
        "descError": descError,
        "objetoRespuesta": objetoRespuesta.toJson(),
      };
}

class ObjetoRespuesta {
  ObjetoRespuesta({
    this.usuarios,
  });

  List<Usuario> usuarios;

  factory ObjetoRespuesta.fromJson(Map<String, dynamic> json) =>
      ObjetoRespuesta(
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}

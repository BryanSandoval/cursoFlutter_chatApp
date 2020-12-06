// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chatAppFlutter/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.codError,
    this.descError,
    this.objetoRespuesta,
  });

  int codError;
  String descError;
  ObjetoRespuesta objetoRespuesta;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        codError: json["CodError"],
        descError: json["DescError"],
        objetoRespuesta: ObjetoRespuesta.fromJson(json["objetoRespuesta"]),
      );

  Map<String, dynamic> toJson() => {
        "CodError": codError,
        "DescError": descError,
        "objetoRespuesta": objetoRespuesta.toJson(),
      };
}

class ObjetoRespuesta {
  ObjetoRespuesta({
    this.usuario,
    this.token,
  });

  Usuario usuario;
  String token;

  factory ObjetoRespuesta.fromJson(Map<String, dynamic> json) =>
      ObjetoRespuesta(
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario.toJson(),
        "token": token,
      };
}

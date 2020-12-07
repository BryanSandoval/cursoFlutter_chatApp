// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) =>
    MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) =>
    json.encode(data.toJson());

class MensajesResponse {
  MensajesResponse({
    this.codError,
    this.descError,
    this.objetoRespuesta,
  });

  int codError;
  String descError;
  ObjetoRespuesta objetoRespuesta;

  factory MensajesResponse.fromJson(Map<String, dynamic> json) =>
      MensajesResponse(
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
    this.mensajes,
  });

  List<Mensaje> mensajes;

  factory ObjetoRespuesta.fromJson(Map<String, dynamic> json) =>
      ObjetoRespuesta(
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    this.de,
    this.para,
    this.mensaje,
    this.createdAt,
    this.updatedAt,
  });

  String de;
  String para;
  String mensaje;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

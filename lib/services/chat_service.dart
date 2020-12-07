import 'package:chatAppFlutter/global/environment.dart';
import 'package:chatAppFlutter/models/mensajes_response.dart';
import 'package:chatAppFlutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chatAppFlutter/models/usuario.dart';
//import 'package:provider/provider.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    final respuesta = await http.get(
        "${Environment.apiUrl}/mensajes/obtenerMensajes/$usuarioId",
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });
    if (respuesta.statusCode == 200) {
      final mensajesResponse = mensajesResponseFromJson(respuesta.body);
      return mensajesResponse.objetoRespuesta.mensajes;
    }

    return [];
  }
  //Usuario get obtUsuarioPara => this.usuarioPara;
}

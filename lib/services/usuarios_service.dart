import 'package:chatAppFlutter/global/environment.dart';
import 'package:chatAppFlutter/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chatAppFlutter/models/usuario.dart';
import 'package:chatAppFlutter/models/usuarios_response.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final respuesta = await http
          .get("${Environment.apiUrl}/usuarios/getUsuarios", headers: {
        'Content-type': 'aplication/json',
        'x-token': await AuthService.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(respuesta.body);
      return usuariosResponse.objetoRespuesta.usuarios;
    } catch (error) {
      return [];
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatAppFlutter/global/environment.dart';
import 'package:chatAppFlutter/models/login_response.dart';
import 'package:chatAppFlutter/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  Usuario get dataUsuario => this.usuario;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

  AuthService();

  Future<bool> login(String email, String contrasenia) async {
    this.autenticando = true;

    final data = {"email": email, "contrasenia": contrasenia};

    final response = await http.post('${Environment.apiUrl}/login/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    print("respuesta: " + response.body);

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.usuario = loginResponse.objetoRespuesta.usuario;
      await this._guardarToken(loginResponse.objetoRespuesta.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String contrasenia) async {
    this.autenticando = true;

    final data = {"nombre": nombre, "email": email, "contrasenia": contrasenia};

    final response = await http.post('${Environment.apiUrl}/login/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    print("respuesta: " + response.body);

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.usuario = loginResponse.objetoRespuesta.usuario;
      await this._guardarToken(loginResponse.objetoRespuesta.token);
      return true;
    } else {
      return jsonDecode(response.body)["DescError"];
    }
  }

  Future<bool> isLoggedIn() async {
    //this.autenticando = true;
    sleep(Duration(seconds: 2));
    try {
      final token = await this._storage.read(key: "token");
      print("respuesta token: " + token);
      if (token.isEmpty) {
        return false;
      }

      final respuesta = await http.get(
          '${Environment.apiUrl}/login/refreshToken',
          headers: {'x-token': token});

      if (respuesta.statusCode == 200) {
        final loginResponse = loginResponseFromJson(respuesta.body);
        this.usuario = loginResponse.objetoRespuesta.usuario;
        await this._guardarToken(loginResponse.objetoRespuesta.token);
        return true;
      } else {
        this.logout();
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future getPrueba() async {
    final response = await http.get("${Environment.apiPrueba}",
        headers: {'Content-Type': 'application/json'});
    print("respuesta: " + response.body);
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    return await _storage.delete(key: "token");
  }

  //10.0.2.2

}

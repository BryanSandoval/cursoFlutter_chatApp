import 'package:chatAppFlutter/models/usuario.dart';
import 'package:chatAppFlutter/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  UsuariosPage({Key key}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final List<Usuario> lista_usuarios = [
    Usuario(uid: '1', nombre: 'María', email: 'test1@test.com', online: true),
    Usuario(
        uid: '2', nombre: 'Pandita', email: 'test2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Monse', email: 'test3@test.com', online: true)
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final Usuario usuario = authService.dataUsuario;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            usuario.nombre,
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "login");
                AuthService.deleteToken();
              }),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: usuario.online
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.blue[400],
                    )
                  : Icon(
                      Icons.offline_bolt,
                      color: Colors.red[400],
                    ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () => _cargarUsuarios(),
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400],
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(lista_usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: lista_usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

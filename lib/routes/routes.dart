import 'package:chatAppFlutter/pages/chat_page.dart';
import 'package:chatAppFlutter/pages/loading_page.dart';
import 'package:chatAppFlutter/pages/login_page.dart';
import 'package:chatAppFlutter/pages/register_page.dart';
import 'package:chatAppFlutter/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};

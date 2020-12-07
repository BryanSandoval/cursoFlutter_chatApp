import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatAppFlutter/routes/routes.dart';
import 'package:chatAppFlutter/services/auth_service.dart';
import 'package:chatAppFlutter/services/socket_service.dart';
import 'package:chatAppFlutter/services/chat_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatService(),
        )
      ],
      child: MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}

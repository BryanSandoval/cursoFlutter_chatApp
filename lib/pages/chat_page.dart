import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatAppFlutter/models/mensajes_response.dart';
import 'package:chatAppFlutter/services/auth_service.dart';
import 'package:chatAppFlutter/services/chat_service.dart';
import 'package:chatAppFlutter/services/socket_service.dart';
import 'package:chatAppFlutter/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  //final AnimationController animationController;

  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  bool estaEscribiendo = false;

  List<ChatMessage> _listaMensajes = [
    /*ChatMessage(
      texto: 'HolaMundo',
      uid: '123',
    ),
    ChatMessage(
      texto: 'Como vas?',
      uid: '123',
    ),
    ChatMessage(
      texto: 'Todo bien , vos?',
      uid: '1234',
    ),
    ChatMessage(
      texto: 'Teletón?',
      uid: '1234',
    ),
    ChatMessage(
      texto: 'Vas a participar?',
      uid: '123',
    ),*/
  ];

  @override
  void initState() {
    super.initState();

    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(this.chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> listaMensajes = await this.chatService.getChat(usuarioID);
    final historial = listaMensajes.map((mensaje) => new ChatMessage(
        texto: mensaje.mensaje,
        uid: mensaje.de,
        animationController: new AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));
    setState(() {
      _listaMensajes.insertAll(0, historial);
    });
    //print(listaMensajes);
  }

  void _escucharMensaje(dynamic payload) {
    print("info mensaje: $payload");

    ChatMessage mensaje = new ChatMessage(
        texto: payload['mensaje'],
        uid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));
    setState(() {
      _listaMensajes.insert(0, mensaje);
    });

    mensaje.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //final chatService = Provider.of<ChatService>(context, listen: false);
    final usuarioPara = chatService.usuarioPara;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                usuarioPara.nombre.substring(0, 2),
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 12,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              usuarioPara.nombre,
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) => _listaMensajes[i],
              itemCount: _listaMensajes.length,
              reverse: true,
            )),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                estaEscribiendo = texto.trim().length > 0 ? true : false;
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue[400]),
                child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null),
              ),
            ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.trim().length == 0) return;
    //print(texto);
    _focusNode.requestFocus();
    _textController.clear();
    final nuevoMensaje = new ChatMessage(
        texto: texto,
        uid: authService.usuario.uid,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 200)));
    _listaMensajes.insert(0, nuevoMensaje);
    nuevoMensaje.animationController.forward();

    setState(() {
      estaEscribiendo = false;
    });

    this.socketService.emit('mensaje-personal', {
      'de': this.authService.dataUsuario.uid,
      'para': this.chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    // TODO: Off del socket
    for (ChatMessage mensaje in _listaMensajes) {
      mensaje.animationController.dispose();
    }
    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}

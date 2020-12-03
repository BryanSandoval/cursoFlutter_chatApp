import 'package:chatAppFlutter/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  //final AnimationController animationController;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 12,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Melissa Flores',
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
        uid: '123',
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 200)));
    _listaMensajes.insert(0, nuevoMensaje);
    nuevoMensaje.animationController.forward();

    setState(() {
      estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: Off del socket
    for (ChatMessage mensaje in _listaMensajes) {
      mensaje.animationController.dispose();
    }
    super.dispose();
  }
}

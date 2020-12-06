import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              MaterialButton(
                  child: Text("Ok"),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => Navigator.pop(context))
            ],
          ));
}

import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget {
  final Color colorAsignado;
  final Function funcPresionar;
  final String textoBoton;

  const Custom_Button(
      {Key key, this.colorAsignado, this.funcPresionar, this.textoBoton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.funcPresionar,
      elevation: 2,
      highlightElevation: 5,
      color: this.colorAsignado,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        child: Center(
            child: Text(
          "Ingrese",
          style: TextStyle(color: Colors.white, fontSize: 17),
        )),
      ),
    );
  }
}

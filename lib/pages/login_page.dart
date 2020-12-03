import 'package:chatAppFlutter/widgets/custom_button.dart';
import 'package:chatAppFlutter/widgets/custom_input.dart';
import 'package:chatAppFlutter/widgets/label_widget.dart';
import 'package:chatAppFlutter/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  titulo: 'Messenger',
                ),
                _Form(),
                Labels(
                  rutaDestino: 'register',
                  textoCuenta1: '¿No tienes cuenta?',
                  textoCuenta2: 'Crea una cuenta ahora!',
                ),
                Text('Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final manejadorCorreo = TextEditingController();
  final manejadorContra = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: manejadorCorreo,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Contraseña',
            keyboardType: TextInputType.text,
            textController: manejadorContra,
            isPassword: true,
          ),
          Custom_Button(
            colorAsignado: Colors.blue,
            funcPresionar: () {
              print("Hola Mundo");
            },
            textoBoton: "Ingresar",
          )
        ],
      ),
    );
  }
}

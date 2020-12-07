import 'package:chatAppFlutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatAppFlutter/services/auth_service.dart';
import 'package:chatAppFlutter/widgets/custom_button.dart';
import 'package:chatAppFlutter/widgets/custom_input.dart';
import 'package:chatAppFlutter/widgets/label_widget.dart';
import 'package:chatAppFlutter/widgets/logo_widget.dart';
import 'package:chatAppFlutter/helpers/mostrar_alerta.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

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
                  titulo: 'Registro',
                ),
                _Form(),
                Labels(
                  rutaDestino: 'login',
                  textoCuenta1: '¿Ya tienes una cuenta?',
                  textoCuenta2: 'Inicia sesión aquí!',
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
  final manejadorNombre = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: manejadorNombre,
          ),
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
            funcPresionar: authService.autenticando
                ? null
                : () async {
                    final registroOk = await authService.register(
                        manejadorNombre.text.trim(),
                        manejadorCorreo.text.trim(),
                        manejadorContra.text.trim());
                    if (registroOk == true) {
                      Navigator.pushReplacementNamed(context, "usuarios");
                      socketService.connect();
                    } else {
                      //Mostrar alerta
                      mostrarAlerta(context, "Registro Incorrecto", registroOk);
                    }
                  },
            textoBoton: "Ingresar",
          )
        ],
      ),
    );
  }
}

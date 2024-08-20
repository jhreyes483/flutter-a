import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  //const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 245, 245),

      body: SafeArea(
        child: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // efecto de salto cuando se hace socroll hacie abajo
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9, // ocupa el 90 % de la pantalla 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Registro'),
                _From(),
                Labels(rutaNavegar: 'login',texto2 : 'Ingrezar con tu cuenta', texto1: 'Ya tienes cuenta?'),
                
                Text('Terminos y condiciones', style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      )
    );
  }
}


class _From extends StatefulWidget {
  //const _From({super.key});

  @override
  State<_From> createState() => __FromState();
}

class __FromState extends State<_From> {

  final emailCtrl   = TextEditingController();
  final passCtrl    = TextEditingController();
  final nombreCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50),

      child: Column(
        children: [
          CustomInput(
            icon           : Icons.mail_outline, 
            placeholder    : 'Correo', 
            keyboardType   : TextInputType.emailAddress,
            textController : emailCtrl, 
          ),
          CustomInput(
            icon           : Icons.perm_identity, 
            placeholder    : 'Nombre', 
            keyboardType   : TextInputType.emailAddress,
            textController : nombreCtrl, 
          ),
          CustomInput(
            icon           : Icons.lock, 
            placeholder    : 'Contraseña', 
            isPassword     : true,
            textController : passCtrl, 
          ),

          BotonAzul(
            text      : 'Crear cuenta', 
            onPressed : authService.autenticando ? null : () async {
            final email    = emailCtrl.text.trim();
            final password = passCtrl.text.trim();
            final nombre   = nombreCtrl.text.trim();

            final registroOk  = await authService.register(email, nombre, password);
            if (registroOk is bool && registroOk ) {
              Navigator.pushReplacementNamed(context, 'login');
            } else {
              // Mostrar alerta de error
              mostrarAlerta(context, 'Error al registrar', registroOk);
            }

              print('Texto de botón');
              print('Email: ${email}');
              print('Contraseña: ${password}');
              print('nombre: ${nombre}');
            }
          )
        ],
      ),
    );
  }

}


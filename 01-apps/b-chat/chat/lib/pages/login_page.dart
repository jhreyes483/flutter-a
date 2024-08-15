import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 245, 245),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(),
            _From(),
            Labels(),
            
            Text('Terminos y condiciones', style: TextStyle(fontWeight: FontWeight.w200))
          ],
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

  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            icon           : Icons.lock, 
            placeholder    : 'Contraseña', 
            isPassword     : true,
            textController : passCtrl, 
          ),

          BotonAzul(
            text      : 'Ingrese', 
            onPressed : (){
              print('Texto de botón');
              print('Email: ${emailCtrl.text}');
              print('Contraseña: ${passCtrl.text}');
            }
          )
        ],
      ),
    );
  }

}


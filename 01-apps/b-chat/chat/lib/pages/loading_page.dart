
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  //const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          return Center(
          child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{
    final authService = Provider.of<AuthService>(context, listen: false); 
    final autenticado = await authService.isLoggedIn();
    if(autenticado){
     // Navigator.pushReplacementNamed(context, 'usuarios');
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => UsuariosPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Desplazamiento de inicio
          const end   = Offset.zero; // Desplazamiento final
          const curve = Curves.easeInOut; // Curva de transición
          var tween   = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
          
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );

    }else{
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
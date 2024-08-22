import 'package:estados/models/usuario.dart';
import 'package:estados/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pagina2Page extends StatefulWidget {


  @override
  State<Pagina2Page> createState() => _Pagina2PageState();
}

class _Pagina2PageState extends State<Pagina2Page> {
  @override
  Widget build(BuildContext context) {
  final usuarioService = Provider.of<UsuarioService>(context); 
  return Scaffold(
      appBar: AppBar(
        title: usuarioService.existeUsuario ? Text('Nombre: ${usuarioService.usuario.nombre}'  ) : Text('pagina 2')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton( 
              child: Text('Establecer usuario', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {
                //final usuarioService = Provider.of<UsuarioService>(context, listen: false); // se deja en false porque esta dentro de un build y si es true daria error porque no puede redibujar
                final newUser = Usuario(nombre: 'Javier', edad: 30, profesiones: ['Ingeniero', 'dev backend', 'dev front']);
                usuarioService.usuario = newUser;
              }
            ),

            MaterialButton( 
              child: Text('Cambiar edad', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {
                usuarioService.cambiarEdad(29);
              }
            ),

            MaterialButton( 
              child: Text('Añadir profecion', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {
                usuarioService.agregarProfesion();
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.accessibility_new),
        onPressed: (){
          Navigator.pushNamed(context, 'pagina1');
        }
      ),
    );
  }
}
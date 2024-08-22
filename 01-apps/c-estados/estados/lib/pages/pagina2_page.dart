import 'package:estados/models/usuario.dart';
import 'package:estados/services/usuario_services.dart';
import 'package:flutter/material.dart';

class Pagina2Page extends StatefulWidget {


  @override
  State<Pagina2Page> createState() => _Pagina2PageState();
}

class _Pagina2PageState extends State<Pagina2Page> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title:Text('pagina 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton( 
              child: Text('Establecer usuario', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {

                final nuevoUsuario = Usuario(nombre: 'Javier', edad: 30, profeciones: ['ingeniero','dev backend','dev front','dev movil']);
                usuarioService.cargarUsuario( nuevoUsuario);
              }
            ),

            MaterialButton( 
              child: Text('Cambiar edad', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {

              }
            ),

            MaterialButton( 
              child: Text('Añadir profecion', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {

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
import 'package:estados/models/usuario.dart';
import 'package:estados/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pagina1Page extends StatefulWidget {


  @override
  State<Pagina1Page> createState() => _Pagina1PageState();
}

class _Pagina1PageState extends State<Pagina1Page> {
  @override
  Widget build(BuildContext context) {
    final usuarioService = Provider.of <UsuarioService> (context, listen: true/* esta pendiente de todos los cambios de la clase re dibujando todos los cugares donde se este escuchando */);
 

    return Scaffold(
      appBar: AppBar(
        title:Text('pagina1'),
        actions:   [
          _iconEliminarUsuario(usuarioService)
        ],
      ),

      body: usuarioService.existeUsuario ? InformacionUsuario( usuarioService.usuario ) : Center( child: Text('No hay usuario seleccionado')) ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.accessibility_new),
        onPressed: (){
          Navigator.pushNamed(context, 'pagina2');
        }
      ),
    );
  }

  Widget _iconEliminarUsuario(usuarioService){
    return  usuarioService.existeUsuario ?
      IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: (){
          usuarioService.removerUsuario();
          Navigator.pushNamed(context, 'pagina2');
        }, 
    )
    : Container();
  }
}

class InformacionUsuario extends StatelessWidget {
  final Usuario usuario;

  const InformacionUsuario(Usuario this.usuario);


  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // envia la comna a un costado
        children: [
          Text('General', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),

          ListTile(title: Text('Nombre: ${this.usuario.nombre}')),
          ListTile(title: Text('Edad: ${this.usuario.edad}')),

          Text('Profeciones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ListTile(title: Text('Profecion 1')),
          ListTile(title: Text('Profecion 2')),
          ListTile(title: Text('Profecion 3')),

        ],
      ),
    );
  }
}
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  //const UsuariosPage({super.key});

  @override
  _UsuariosPageState createState() => _UsuariosPageState();

}

class _UsuariosPageState extends State<UsuariosPage>{


  final usuarios = [
    Usuario(uid: '1', online: true, nombre: 'maria', email: 'maria@hotmail.com'),
    Usuario(uid: '2', online: false, nombre: 'javier', email: 'javier@hotmail.com'),
    Usuario(uid: '3', online: false, nombre: 'brian', email: 'brian@hotmail.com'),
    Usuario(uid: '4', online: true, nombre: 'ingrid', email: 'ingrid@hotmail.com')
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre', style: TextStyle(color: Colors.black54)),
        elevation       : 1,
        backgroundColor : Colors.white,
        leading         : IconButton(
          icon          : Icon(Icons.exit_to_app, color: Colors.black54), 
          onPressed: () {  },
        ),
        actions: [
          Container(
            margin : EdgeInsets.only(right: 10),
            child  : 
            //Icon(Icons.check_circle, color: Colors.blue[400] ) 
            Icon(Icons.offline_bolt, color: Colors.red )
          )
        ],
      ),

      body: ListView.separated(
        physics      : BouncingScrollPhysics(), // se ve igual en Ios y android
        itemBuilder  : (_,i) =>_usuarioListTitle( usuarios[i] ), 
        separatorBuilder : (_,i) =>Divider(), 
        itemCount        : usuarios.length
        )
    );
  }

  ListTile _usuarioListTitle(Usuario usuario ){
    return ListTile(
        title   : Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading : CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(usuario.nombre.substring(0,2) ),
        ),
        trailing : Container(
          width : 10,
          height: 10,
          decoration: BoxDecoration( 
            color        : usuario.online ? Colors.green[300] : Colors.red,
            borderRadius : BorderRadius.circular(100) 
          ),
        ),

      );
  }
}
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart'; // instalar esta libreria
/// video 63
class UsuariosPage extends StatefulWidget {
  //const UsuariosPage({super.key});

  @override
  _UsuariosPageState createState() => _UsuariosPageState();

}

class _UsuariosPageState extends State<UsuariosPage>{
RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', online: true, nombre: 'Maria', email: 'maria@hotmail.com'),
    Usuario(uid: '2', online: false, nombre: 'Javier', email: 'javier@hotmail.com'),
    Usuario(uid: '3', online: false, nombre: 'Brian', email: 'brian@hotmail.com'),
    Usuario(uid: '4', online: true, nombre: 'Ingrid', email: 'ingrid@hotmail.com')
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

      body: SmartRefresher( // pull refresh
        controller     : _refreshController,
        enablePullDown : true,
        onRefresh      : _cargarUsuarios,

        header         : WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400] ),
          waterDropColor: const Color.fromARGB(255, 65, 163, 243),
        ),
        child          : _listViewUsuarios(),
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics      : BouncingScrollPhysics(), // se ve igual en Ios y android
      itemBuilder  : (_,i) =>_usuarioListTitle( usuarios[i] ), 
      separatorBuilder : (_,i) =>Divider(), 
      itemCount        : usuarios.length
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

  void _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
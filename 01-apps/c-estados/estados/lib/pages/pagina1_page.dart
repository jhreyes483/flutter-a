import 'package:estados/bloc/usuario/usuario_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pagina1Page extends StatefulWidget {


  @override
  State<Pagina1Page> createState() => _Pagina1PageState();
}

class _Pagina1PageState extends State<Pagina1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('pagina1'),
      ),

      body: BlocBuilder <UsuarioCubit, UsuarioState> (builder: (_, state) {

        if(state is UsuarioIntial){
          return Center(child: Text('No hay informacion del usuario'));
        }else {
          return  InformacionUsuario();
        }

      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.accessibility_new),
        onPressed: (){
          Navigator.pushNamed(context, 'pagina2');
        }
      ),
    );
  }
}

class InformacionUsuario extends StatelessWidget {

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

          ListTile(title: Text('Nombre: ')),
          ListTile(title: Text('Edad: ')),

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
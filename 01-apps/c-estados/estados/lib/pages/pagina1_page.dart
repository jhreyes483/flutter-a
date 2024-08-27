import 'package:estados/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/bloc/user/user_bloc.dart';


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
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: (){
              BlocProvider.of<UserBloc>(context, listen: false)
                .add(DeleteUser());
            },
          )
        ],
      ),

      body: BlocBuilder<UserBloc, UserState> ( // creacion de User Bloc (Cada vez que haya un cambio en state esto se re dibuja)
        builder: (_, state) {

          return state.existUser 
          ? InformacionUsuario(user: state.user!/* ! siempre existe */) 
          : const Center(
            child: Text('No hay usuario seleccionado'),
          );

        },
      ),


      //InformacionUsuario(),
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

  final User user;

  const InformacionUsuario({
      super.key, 
      required this.user
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // envia la comna a un costado
        children: [
          const  Text('General', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
          const  Divider(),

          ListTile(title: Text('Nombre: ${user.nombre}')),
          ListTile(title: Text('Edad: ${user.edad}')),

          const Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          // desestructura user lo recorre y genera un ListTitle por cada item
          ...user.profesiones.map(
            (prof) => ListTile(title: Text(prof) ) 
          ).toList()
          /*
          ListTile(title: Text('Profesion 1')),
          ListTile(title: Text('Profesion 2')),
          ListTile(title: Text('Profesion 3')),
          */

        ],
      ),
    );
  }
}
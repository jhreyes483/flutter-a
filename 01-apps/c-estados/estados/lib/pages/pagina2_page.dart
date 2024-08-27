import 'package:estados/bloc/user/user_bloc.dart';
import 'package:estados/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pagina2Page extends StatefulWidget {


  @override
  State<Pagina2Page> createState() => _Pagina2PageState();
}

class _Pagina2PageState extends State<Pagina2Page> {
  @override
  Widget build(BuildContext context) {
    final userBloc =  BlocProvider.of<UserBloc>(context, listen: false); // busca la estancia en el contexto para usarla 
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
                final newUser = User(nombre: 'Javier', edad: 30, profesiones: ['dev','Ingeniero']);
                userBloc.add( ActivateUser(newUser) ); // dispara el evento 
              }
            ),

            MaterialButton( 
              child: Text('Cambiar edad', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {
                userBloc.add( ChangeUserAge(age: 29) ); // dispara el evento 
              }
            ),
            MaterialButton( 
              child: Text('Añadir profesion', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {
                userBloc.add( AddProfesion(profesion: 'test profesion'));
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
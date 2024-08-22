import 'package:estados/bloc/usuario/usuario_cubit.dart';
import 'package:estados/models/usuario.dart';
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

   body: BlocBuilder<UsuarioCubit, UsuarioState>( builder: (_, state) { // escucha los cambios en el estado

        if(state is UsuarioIntial){
          return Center(child: Text('No hay informacion del usuario'));
        }else if (state is UsuarioActivo){

          return  InformacionUsuario(state.usuario);
        }else {
          // Caso por defecto para manejar estados desconocidos
          return Center(child: Text('Estado desconocido'));
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
  final Usuario usuario;

  const InformacionUsuario(this.usuario);


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

          ListTile(title: Text('Nombre: ${usuario.nombre}')),
          ListTile(title: Text('Edad: ${usuario.edad}')),

          Text('Profeciones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),

          ...usuario.profesiones.map(
            (profesion) => ListTile( title: Text(profesion))
          ).toList()
          /*
          ListTile(title: Text('Profecion 1')),
          ListTile(title: Text('Profecion 2')),
          ListTile(title: Text('Profecion 3')),
          */

        ],
      ),
    );
  }
}
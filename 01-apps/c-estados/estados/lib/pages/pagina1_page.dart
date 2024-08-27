import 'package:estados/controllers/usuario_controller.dart';
import 'package:estados/models/usuario.dart';
import 'package:estados/pages/pagina2_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pagina1Page extends StatefulWidget {


  @override
  State<Pagina1Page> createState() => _Pagina1PageState();
}

class _Pagina1PageState extends State<Pagina1Page> {
  @override
  Widget build(BuildContext context) {
    final usuarioCtrl = Get.put(UsuarioController()); // injecta el usuario controller al context


    return Scaffold(
      appBar: AppBar(
        title:Text('pagina1'),
      ),

      body: Obx(() => usuarioCtrl.existeUsuario.value
        ? informacionUsuario()
        : NoInfo()
       ), // observa los cambios de estado y re dibuja
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.accessibility_new),
        onPressed: (){
          // redirigir a otra pagina normal
          //Navigator.pushNamed(context, 'pagina2'); 

          // redirigir a otra pagina con getx
          //Get.to(Pagina2Page());
          // o
          // Get.toNamed('pagina2');
          // o con argumentos
          Get.toNamed('pagina2', arguments: {
            'nombre':'Javier',
            'edad': 30
          });
        }
      ),
    );
  }
}

class NoInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('No hay usuario seleccionado'),
      )
    );
  }
}

class informacionUsuario extends StatelessWidget {

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

          Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ListTile(title: Text('Profesion 1')),
          ListTile(title: Text('Profesion 2')),
          ListTile(title: Text('Profesion 3')),

        ],
      ),
    );
  }
}
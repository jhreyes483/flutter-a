import 'package:estados/models/usuario.dart';
import 'package:get/get.dart';

class UsuarioController extends GetxController {

  var existeUsuario = false.obs; // un observador
  var usuario       = Usuario().obs;


  void cargarUsuario( Usuario pUsuario ){
    this.existeUsuario.value = true;
    this.usuario.value = pUsuario;
  }

  void cambiarEdad(int edad){
    this.usuario.update((val){
      val!.edad = edad;
    });
  }
}
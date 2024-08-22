import 'dart:async';

import 'package:estados/models/usuario.dart';

class _UsuarioService {
  
  Usuario? _usuario;

  final StreamController<Usuario> _usuarioStreamController = new StreamController<Usuario>.broadcast();// refresca en todos laados cuando se actualiza algo del usuario


  Usuario? get usuario               => this._usuario;
  bool     get existeUsuario         => ( this._usuario != null) ? true : false;
  Stream<Usuario> get usuarioStream  => _usuarioStreamController.stream;




  void cargarUsuario( Usuario user ) {
    this._usuario = user;
    _usuarioStreamController.add(user);
    print('cargo usuario $user');
  }


  void cambiarEdad(int edad){
    this._usuario!.edad = edad;
    _usuarioStreamController.add( this._usuario! );
  }

  dispose() {
    _usuarioStreamController?.close();
  }


}

final usuarioService = _UsuarioService();



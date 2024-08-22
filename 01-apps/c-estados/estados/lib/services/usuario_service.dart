import 'package:estados/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioService with ChangeNotifier /* notifica el estado o cambios */{
  Usuario? _usuario;


  Usuario get usuario       => this._usuario!;
  bool    get existeUsuario => ( this._usuario != null ) ? true : false;

  set usuario(Usuario user){
    this._usuario = user;
    notifyListeners();
  }

  void cambiarEdad(int edad){
    this._usuario!.edad = edad;
    notifyListeners();
  }

  void removerUsuario(){
    this._usuario= null;
    notifyListeners();
  }
}


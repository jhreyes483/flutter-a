part of 'usuario_cubit.dart';

@immutable
abstract class UsuarioState{}

  class UsuarioIntial extends UsuarioState{
    final existeUsuario = false;
  }

  class UsuarioActivo extends UsuarioState {
    final existeUsuario = true;
    final Usuario usuario;

    UsuarioActivo(this.usuario); // contructor
  }
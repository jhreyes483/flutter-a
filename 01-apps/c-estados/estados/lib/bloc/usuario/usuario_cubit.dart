import 'package:estados/models/usuario.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super( UsuarioIntial());

  void seleccionarUsuario(Usuario user){
    emit( UsuarioActivo(user));  // cambia el estado de la clase
  }


  void cambiarEdad(int edad){
    final currentState = state;
    if(currentState is UsuarioActivo){
      final newUser = currentState.usuario.copyWith(edad: edad);

      currentState.usuario.edad = edad;
      emit( UsuarioActivo(newUser));
    }
  }

  void agregarProfesion(){
    final currentState = state;
    if(currentState is UsuarioActivo){

      final newProfesiones = [
        ...currentState.usuario.profesiones,
        'Profesion ${currentState.usuario.profesiones.length}'
      ];
      final newUser = currentState.usuario.copyWith( profesiones:  newProfesiones );

      emit( UsuarioActivo(newUser));
    }
  }

  void borrarUsuario(){
    emit(UsuarioIntial());
  }


}
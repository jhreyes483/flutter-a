import 'package:estados/models/usuario.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super( UsuarioIntial());

  void seleccionarUsuario(Usuario user){
    emit( UsuarioActivo(user));  // cambia el estado de la clase
  }


}
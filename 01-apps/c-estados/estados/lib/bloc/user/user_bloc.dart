import 'package:estados/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent,UserState> {
  UserBloc() :super(const UserInitialState()){

 on<ActivateUser>((event, emit) { // este se usa en el widget
  print('AcitivateUser called');
  emit(UserSetState(event.user));// emite el nuevo estado
    });

  on<ChangeUserAge>((event, emit){
    print('ChangeUserAger called');
    if( !state.existUser ) return;
    //state.user!.edad = event.age; // se muta el estado

    emit(UserSetState( state.user!.copyWith(edad: event.age ) ));

    print('Se emitira un nuevo estado');
  });

  on<AddProfesion>((event, emit) {
    if(!state.existUser) return;
    
    final newProfesiones = [
      ...state.user!.profesiones,
      'Profesion ${state.user!.profesiones.length}'
    ];
    emit(UserSetState(state.user!.copyWith(profesiones: newProfesiones)));

  });

  on<DeleteUser>((event, emit) {
    emit(UserInitialState());
  });

  }


}
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
  }
}
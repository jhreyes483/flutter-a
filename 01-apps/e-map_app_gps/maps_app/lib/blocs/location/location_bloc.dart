import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? positionSream;

  LocationBloc() : super( const LocationState() ) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future getCurrentPosition() async {
    final position =  await Geolocator.getCurrentPosition();
    print('Position $position');
    // TODO: retornar unobjeo de tipo LatiLng
  }

  /*
  Escucha los cambios cambio de la ubicacion del usuario
  */
  void startFollowingUser () {
    print('startFollowingUser');
    positionSream = Geolocator.getPositionStream().listen((event){
      final position = event;
      print('postionEvvent: $position');

    });

  }

  void stopFollowingUser(){
    positionSream?.cancel();
    print('stopFollowingUser');
  }

/*
Se ejecuta una vez se cierra el widget
*/
  @override
  Future<void>close(){
    stopFollowingUser();
    return super.close();
  }
}

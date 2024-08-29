import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? positionSream;

  LocationBloc() : super( const LocationState() ) {

    on<OnStartFollowingUser>((event, emit) => emit( state.copyWith( followingUser: true ) ));
    on<OnStopFollowingUser>((event,emit) =>emit( state.copyWith(followingUser: false)) );


    on<OnNewUserLocationEvent>((event, emit)  {
      emit(
        state.copyWith(
          lastKonwnLocation: event.newLocation,
          myLocationHistory: [ ...state.myLocationHistory, event.newLocation ],
        )
      );
      // TODO: implement event handler
    });
  }

  Future getCurrentPosition() async {
    final position =  await Geolocator.getCurrentPosition();
    add( OnNewUserLocationEvent(LatLng(position.latitude, position.longitude))); // dispara el evento
    print('Position $position');
    // TODO: retornar unobjeo de tipo LatiLng
  }

  /*
  Escucha los cambios cambio de la ubicacion del usuario
  */
  void startFollowingUser () {
    
    add(OnStartFollowingUser());
    print('startFollowingUser');
    positionSream = Geolocator.getPositionStream().listen((event){
      final position = event;
      add( OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
      print('postionEvvent: $position');

    });

  }

  void stopFollowingUser(){
    add(OnStopFollowingUser());
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

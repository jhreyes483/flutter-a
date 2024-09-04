import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

import 'package:maps_app/themes/uber.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  MapBloc({required this.locationBloc}) : super(MapState()) { // estado inicial
    on<MapEvent/* cuando se ejecuta el evento */ >((event, emit) {

    });

    on<OnMapInitialzedEvent /* cuando se ejecuta el evento */>(_onInitMap);
    on<OnStartFolloingUserEvent /* cuando se ejecuta el evento */>(_onStartFollowingUser);
    on<OnStopFolloingUserEvent /* cuando se ejecuta el evento */>((event, emit)  => emit(state.copyWith( isFollowingUser : false)) );
    on<UpdateUserPolylineEvent>(_onPoliylineNewPoint);
    on<OnToggleUserRoute>(_onToogleShowRoute);

    locationBloc.stream.listen((locationState){ /* escucha los cambios */

      if(locationState.lastKnownLocation != null ){
        /* agrega una nueva ubicacion al historico para dibujar la linea de recorrido */
        add( UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if( !state.isFollowingUser) return;
      if( locationState.lastKnownLocation == null ) return;

      moveCamera(locationState.lastKnownLocation!);
    });

  }

  void _onToogleShowRoute(OnToggleUserRoute event, Emitter<MapState> emit){
    print('execute event onToogleShowRoute');
    emit(state.copyWith( showMyRoute: !state.showMyRoute));
  }

  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit){
    _mapController = event.controller;
    _mapController!.setMapStyle(  jsonEncode(uberMapTheme) );

    emit( state.copyWith(isMapInitialized: true)); /* emite el evento */
  }

void _onStartFollowingUser( OnStartFolloingUserEvent event, Emitter<MapState> emit ){
  emit(state.copyWith(isFollowingUser: true));
  if( locationBloc.state.lastKnownLocation == null ) return;
  moveCamera(locationBloc.state.lastKnownLocation!);

}
/** crea la polyline */
void _onPoliylineNewPoint( UpdateUserPolylineEvent event, Emitter<MapState> emit ){
  final myRoute = Polyline(
    polylineId:const PolylineId('myRoute'),
    color: Colors.black,
    width: 5,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    points: event.userLocations
  ); // propío de google maps de flutter

  final currentPolylines = Map <String, Polyline>.from(state.polylines); //crea una nueva instancia de Map<String, Polyline> a partir del mapa existente state.polylines
  currentPolylines['myRoute'] = myRoute;

  emit( state.copyWith(polylines: currentPolylines) );
}

  void moveCamera(LatLng newLocation){
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera(cameraUpdate);
  }

}

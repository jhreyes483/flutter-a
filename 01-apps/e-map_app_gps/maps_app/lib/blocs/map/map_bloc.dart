import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show GoogleMapController, LatLng;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController? _mapController;

  MapBloc() : super(MapState()) { // estado inicial
    on<MapEvent/* cuando se ejecuta el evento */ >((event, emit) {

    });

    on<OnMapInitialzedEvent /* cuando se ejecuta el evento */>(_onInitMap);
  }

  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit){
    _mapController = event.controller;
    emit( state.copyWith(isMapInitialized: true)); /* emite el evento */
  }
}

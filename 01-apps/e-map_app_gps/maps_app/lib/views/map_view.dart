import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polyline;

  const MapView({
    super.key, 
    required this.initialLocation, 
    required this.polyline
    });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context); // llama el mapBloc del context

    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15
    );
    final size =MediaQuery.of(context).size; // toma las dimensiones de la pantalla 

    return SizedBox( // genera una caja con un tamaño especifico
      width:  size.width,
      height: size.height,
      child: Listener( // detecta cuando se mueve el dedo por la pantalla
      onPointerMove: ( pointerMoveEvent ) => mapBloc.add( OnStopFolloingUserEvent()),

        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false, // hace que aparezca el compas
          myLocationEnabled: true, // muestra la ubicación actual del usuario
          zoomControlsEnabled: false, // botones para controlar el zoom
          myLocationButtonEnabled: false,
          polylines: this.polyline, // mostrar o oucultar las line de trayecto
        
          onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller)), // establece el controlador en el bloc
          onCameraMove:(position) => mapBloc.mapCenter = position.target
        
          // TODO Markers
          // TODO polyline
          // TODO cuando se mueve el mapa
        
          ),
      )
      );
  }
}
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;

  const MapView({
    super.key, 
    required this.initialLocation
    });

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15
    );
    final size =MediaQuery.of(context).size; // toma las dimensiones de la pantalla 

    return SizedBox( // genera una caja con un tamaño especifico
      width:  size.width,
      height: size.height,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: false, // hace que aparezca el compas
        myLocationEnabled: true, // muestra la ubicación actual del usuario
        zoomControlsEnabled: false, // botones para controlar el zoom
        myLocationButtonEnabled: false,

        // TODO Markers
        // TODO polyline
        // TODO cuando se mueve el mapa

        )
      );
  }
}
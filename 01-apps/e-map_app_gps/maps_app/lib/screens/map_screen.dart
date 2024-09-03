import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/btn_toggle_user_route.dart';
import 'package:maps_app/widgets/widgets.dart';


class MapScreen extends StatefulWidget {

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState(){ /* este evento se dispara una vez el  StatefulWidget  se ha cargado completamente */
    super.initState();
      locationBloc =  locationBloc = BlocProvider.of<LocationBloc>(context); 
      locationBloc.startFollowingUser();
}

  @override
  void dispose() {
    locationBloc.stopFollowingUser(); // limpia la suscripción
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>( // escucha los cambios del bloc
        builder: (context, locationState){

          if(locationState.lastKnownLocation == null ) return const Center(child: Text('Espere por favor...'),);
          

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {        
              Map<String,Polyline>polylines = Map.from( mapState.polylines); // crea una copia
              if(!mapState.showMyRoute){

                polylines.removeWhere((key,value)  => key == 'myRoute' ); // Elimina la linea de la ruta del mapa
              }

              return SingleChildScrollView( // envuelve en un scroll
                      child: Stack( // sirve para colocar un widget encima de otro
                        children: [
                          MapView( 
                            initialLocation: locationState.lastKnownLocation!,
                            polyline: polylines.values.toSet(),
                          ),
                          const SearchBarApp(),
                          const ManuelMarker()
                        ],
                      ),
                    );
            },
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnToggleUserRoute(),
          BtnCurrenLocation(),
          BtnFollowUser(),

        ],
      ),
  );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/views/views.dart';
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
        builder: (context, state){

          if(state.lastKnownLocation == null ) return const Center(child: Text('Espere por favor...'),);

          return SingleChildScrollView( // envuelve en un scroll
            child: Stack( // sirve para colocar un widget encima de otro
              children: [
                MapView( initialLocation: state.lastKnownLocation!)
                // TODO: botones...
              ],
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnCurrenLocation(),
          BtnFollowUser()
        ],
      ),
  );
  }
}
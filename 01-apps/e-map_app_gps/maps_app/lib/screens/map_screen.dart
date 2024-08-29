import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';


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
    locationBloc.stopFollowingUser(); // limpia la suscribcion
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state){

          if(state.lastKonwnLocation == null ) return const Center(child: Text('Espere por favor...'),);
          return Center(
            child: Text('${state.lastKonwnLocation!.latitude}, ${state.lastKonwnLocation!.latitude}'),
          );
        },
      )
  );
  }
}
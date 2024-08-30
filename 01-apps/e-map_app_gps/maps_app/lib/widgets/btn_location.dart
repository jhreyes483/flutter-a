import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/ui/custom_snackbar.dart';

class BtnCurrenLocation extends StatelessWidget {
  const BtnCurrenLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc      = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only( bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined, color: Colors.black),
          onPressed: () {
            final userLocation = locationBloc.state.lastKnownLocation;
            if(userLocation == null ){
              final snack = CustomSnackbar(message: 'No hay ubicación'); // iu personalizado
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
              /*
              genera una alerta standar en la parte de abajo
              const snack =  SnackBar(content: Text('Hola mundo'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
              */     
            }
            mapBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}
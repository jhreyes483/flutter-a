import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_app/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder <GpsBloc, GpsState> ( // escucha los cambios del bloc
          builder: (context, state){
            return !state.isGpsEnabled 
            ? const _EnableGpsMessage()
            : const _AccessButton() ;
          })

      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso a GPS'),
        MaterialButton(
          child: const Text('Solicitar aceceso', style: TextStyle(color: Colors.white)),
          color: Colors.black,
          shape:  const StadiumBorder(), // es como un border radius
          splashColor: Colors.transparent, // quita el efecto del splash al hacer click
          elevation: 0,
          onPressed: () {

          }
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Debe de habilitar el GPS',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)
    );
  }
}


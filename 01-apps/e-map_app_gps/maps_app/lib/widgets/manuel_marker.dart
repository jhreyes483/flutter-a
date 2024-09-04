import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';
import 'package:maps_app/blocs/search/search_bloc.dart';

class ManuelMarker extends StatelessWidget {
  const ManuelMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {

        print('ManuelMarker  St');
        print(state);
        //return const _ManuelMarkerBody();
        
        return state.displayManualMarker == true
        ? const _ManuelMarkerBody()
        : const SizedBox(); // Similar al container pero no va cambiar 
      
      },
    );
  }
}


class _ManuelMarkerBody extends StatelessWidget {


  const _ManuelMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    /* iciono de seleccionar ubicacion */
    final size = MediaQuery.of(context).size; // adapta a toda la pantalla 
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox( // similar al container
      width: size.width,
      height: size.height,
      child: Stack( // sirve para colocar un widget encima de otro
        children: [
            const Positioned( // posiciona el widgwt segun el top y left
              top: 70,
              left: 20,
              child: _BtnBack()
            ),


          Transform.translate( // sube un poco en el offset
            offset: const Offset(0,-22),

          
            child: Center(
              child: BounceInDown( // animacion para que caiga el icono
                from: 100,
                child:const Icon(Icons.location_on_rounded, size: 50)
                ),
            ),
          ),

          /* Boton de confirmar */
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp( // animacion
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width -120,
                child: const Text('Confirmar destino', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                color: Colors.black,
                elevation: 0,
                height:40,
                shape: const StadiumBorder(), // redondea los bordes del boton
                onPressed: () async {
                  final start = locationBloc.state.lastKnownLocation;
                  if(start == null ) return;

                  final end = mapBloc.mapCenter;
                  if(end == null) return;
                  await searchBloc.getCoorsStartToEnd(start, end);
                },
              ),
            )
          )


        ],
      )
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInLeft( // animacion
    duration: const Duration(microseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            BlocProvider.of<SearchBloc>(context).add(
              OnDeactivateManualMarkerEvent()
            );
            // TODO: cancelar el marcador manual
          },
          ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/blocs/search/search_bloc.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate <SearchResult> {

  SearchDestinationDelegate():super(
    searchFieldLabel: 'Buscar...'
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return 
    [ IconButton(
      icon: const Icon( Icons.clear ), 
      onPressed: (){
        query ='';
      }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // boton back dentro del input
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios), 
      onPressed:  () {
        close(context, SearchResult(cancel: true));
      }
      );

  }

  @override
  Widget buildResults(BuildContext context) {
    //return const Text('buildResults');

    //final SearchBloc = BlocProvider.of<SearchBloc>(context);
    final searchBloc   = BlocProvider.of<SearchBloc>(context);
    final proximity    = BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;
    searchBloc.getPlacesByQuery( proximity, query );


    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;

        return ListView.separated(
          itemCount: places.length,
          itemBuilder: ( context, i ) {
            final place = places[i];
            return ListTile(
              title: Text( place.text ),
              subtitle: Text( place.placeName ),
              leading: const Icon( Icons.place_outlined, color: Colors.black ),
              onTap: () {

                final result = SearchResult( 
                  cancel: false, 
                  manual: false,
                  position: LatLng( place.center[1], place.center[0] ),
                  name: place.text,
                  description: place.placeName
                );

                //searchBloc.add( AddToHistoryEvent(place) );
                
                close(context, result );
              }
            );
          }, 
          separatorBuilder: ( context, i ) => const Divider(), 
        );
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text('colocar la ubicacion manualmente', style: TextStyle( color: Colors.black),),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);


             close(context, result);
          }
        )
      ],
    );
  }

}
import 'package:flutter/material.dart';
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
    return const Text('buildResults');
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
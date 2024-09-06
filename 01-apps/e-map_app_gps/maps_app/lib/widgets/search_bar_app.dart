import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/blocs/search/search_bloc.dart';

//SearchBarApp

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <SearchBloc, SearchState> (
      builder: (context, state){
        return state.displayManualMarker
        ? const SizedBox()
        : FadeInDown(
          duration: const Duration(microseconds: 300),
          child: const _SearchBarBody()
          ) ;
      }
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({super.key});

  void onSearchResult( BuildContext context, SearchResult result){
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final t = result.manual!;
    print('manual ------ $t');
    if(result.manual == true ){
      print('entro ----');
        searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( // hace que el contenido no se superponga a las areas seguras de la pantalla
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        // color: Colors.red,
        width: double.infinity,
        height: 50,
        child: GestureDetector( // detecta cuando el user toca en la pantalla este widget
          onTap: () async {
           final result = await showSearch(context: context, delegate: SearchDestinationDelegate()); // Widget de search
            if(result == null ) return;
            onSearchResult(context, result);
            /// print(result);
          },
          child: Container( 
          padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 13),
          child: const Text('Donde quieres ir?', style: const TextStyle(color: Colors.black87)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5)
              )
            ]
          ),
          

          )
        ),
      ),
    );
  }
}
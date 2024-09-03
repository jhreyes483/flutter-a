part of 'search_bloc.dart';

@immutable
class SearchState extends Equatable /* compara las varibles en los cambios de estado*/ {
  
  final displayManualMarker;


  const SearchState({
    this.displayManualMarker = false
  });

  SearchState copyWith({
    bool? displayManualMarker 
  })
  => SearchState(
    displayManualMarker: displayManualMarker ?? this.displayManualMarker
  );

  @override
  // TODO: implement props
  List<Object?> get props => [ displayManualMarker ];

  @override
  String toString(){

    return '{ displayManualMarker: $displayManualMarker }';
  }

}


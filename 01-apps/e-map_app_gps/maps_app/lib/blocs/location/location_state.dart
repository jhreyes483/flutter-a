part of 'location_bloc.dart';

class LocationState extends Equatable /* compara cada propiedad para saber si dos estancias son iguales */ {

  final bool followingUser;
  //TODO 
  // ultimo geolocation
  // historia

  const LocationState({
    this.followingUser = false
  });
  
  @override
  List<Object> get props => [ followingUser /* esto hace que al comparar se tomeen cuenta esta pripiedad */ ];
}



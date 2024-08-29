part of 'location_bloc.dart';

class LocationState extends Equatable /* compara cada propiedad para saber si dos estancias son iguales */ {

  final bool followingUser;
  final LatLng?lastKonwnLocation;
  final List<LatLng>  myLocationHistory; 



  //TODO 
  // ultimo geolocation
  // historia

  const LocationState({ // constructor
    this.followingUser = false,
    this.lastKonwnLocation,
    myLocationHistory 
  }): myLocationHistory = myLocationHistory ?? const [];


  LocationState copyWith({
  final bool? followingUser,
  final LatLng? lastKonwnLocation,
  final List<LatLng>? myLocationHistory,

  }) => LocationState(
   followingUser    : followingUser ?? this.followingUser,
  lastKonwnLocation : lastKonwnLocation ?? this.lastKonwnLocation,
  myLocationHistory : myLocationHistory ?? this.myLocationHistory,
  );

  
  @override
  List<Object?> get props => [ followingUser , lastKonwnLocation, myLocationHistory /* esto hace que al comparar se tomeen cuenta esta pripiedad */ ];
}



part of 'location_bloc.dart';

class LocationState extends Equatable /* compara cada propiedad para saber si dos estancias son iguales */ {

  final bool followingUser;
  final LatLng?lastKnownLocation;
  final List<LatLng>  myLocationHistory; 



  //TODO 
  // ultimo geolocation
  // historia

  const LocationState({ // constructor
    this.followingUser = false,
    this.lastKnownLocation,
    myLocationHistory 
  }): myLocationHistory = myLocationHistory ?? const [];


  LocationState copyWith({
  final bool? followingUser,
  final LatLng? lastKnownLocation,
  final List<LatLng>? myLocationHistory,

  }) => LocationState(
   followingUser    : followingUser ?? this.followingUser,
  lastKnownLocation : lastKnownLocation ?? this.lastKnownLocation,
  myLocationHistory : myLocationHistory ?? this.myLocationHistory,
  );

  
  @override
  List<Object?> get props => [ followingUser , lastKnownLocation, myLocationHistory /* esto hace que al comparar se tomen cuenta esta propiedad */ ];
}



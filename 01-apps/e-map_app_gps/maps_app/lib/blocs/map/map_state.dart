part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  // Polylines
  final Map<String, Polyline> polylines;
  /*
  mi_ruta: {
    id: polylineID Google,
    points [ lat, ing], [12345,123456], [123456, 123456]
    width: 3
    color: black87
  }
  */



  const MapState({
    this.showMyRoute =true,
    this.isMapInitialized = false,
    this.isFollowingUser = true,
     Map<String, Polyline>? polylines
  }): polylines = polylines ?? const {};
  
  MapState copyWith({
    bool? showMyRoute,
    bool? isMapInitialized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines
  }) => MapState(
    showMyRoute: showMyRoute ?? this.showMyRoute,
    isMapInitialized:  isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    polylines: polylines ?? this.polylines,
  );

  @override
  List<Object> get props => [ isMapInitialized, isFollowingUser,  showMyRoute, polylines ];
}



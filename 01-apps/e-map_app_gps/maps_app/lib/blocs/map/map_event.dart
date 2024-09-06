part of 'map_bloc.dart';

class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialzedEvent extends MapEvent {
  final GoogleMapController controller;

  OnMapInitialzedEvent(this.controller);
}

class OnStopFolloingUserEvent extends MapEvent {}
class OnStartFolloingUserEvent extends MapEvent {}
class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;

  const UpdateUserPolylineEvent(
    this.userLocations
  );
}

class OnToggleUserRoute extends MapEvent {
  
}

class DisplayPolylinesEvent extends MapEvent {
  final Map <String,Polyline> polylines;
  final Map <String, Marker> markers;
  const DisplayPolylinesEvent(this.polylines, this.markers);
}
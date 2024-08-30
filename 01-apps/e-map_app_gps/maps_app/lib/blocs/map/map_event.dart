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

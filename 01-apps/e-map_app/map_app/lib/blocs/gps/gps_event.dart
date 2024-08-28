part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsEnabledEvent extends GpsEvent {}

class GpsPermissionGrantedEvent extends GpsEvent {}
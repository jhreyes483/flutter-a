import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';


class GpsBloc extends Bloc<GpsEvent, GpsState> {
   StreamSubscription? gpsServiceSubscription;

  GpsBloc() : super( const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false) ) {
    
    on<GpsAndPermissionEvent> ((event, emit) => emit( state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      )) 
    );
    _init();
  }

 Future<void> _init() async {

    final gpsInitStatus = await Future.wait([
        _checkGpsStatus(),
      //  _isPermissionGranted(),
    ]);

    add( GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0], 
     // isGpsPermissionGranted: gpsInitStatus[1],
     isGpsPermissionGranted: true
    ));
  }

/*
    add( GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
    ));
  }
*/
/*
  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }
*/  

  Future<bool> _checkGpsStatus() async {

    final isEnable = await Geolocator.isLocationServiceEnabled();
    print('SERVER IS ENABLE --- : $isEnable');

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1 ) ? true : false;
      print('SERVER STATUS --- : $isEnabled');
      add( GpsAndPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    return isEnable;  
  }

/*
  Future<void> _init() async { // escucha el estado del gps

try {
    final isEnabled = await _checkGpsStatus();
    print('isEnabled: $isEnabled');

    // Listen to GPS status changes
    Geolocator.getServiceStatusStream().listen(
      (status) {
        print('Service status: $status');
      },
      onError: (error) {
        print('Error listening to GPS service status: $error');
      },
    );
  } catch (e) {
    print('Error initializing GPS: $e');
  }
  /*
    print('entro a init de bloc');
    final  isEnabled  = await _checkGpsStatus();
    print('isEnalbe: $isEnabled');
    */
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable  =await Geolocator.isLocationServiceEnabled(); 
    Geolocator.getServiceStatusStream().listen((event){
      print('server status $event');
    });
    return isEnable;
  }
*/
}

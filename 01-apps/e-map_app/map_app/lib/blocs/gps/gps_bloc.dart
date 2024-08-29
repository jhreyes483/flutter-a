import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  GpsBloc() : super( const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false) ) {
    
    on<GpsAndPermissionEvent> ((event, emit) => emit( state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted
      )) 
    );
    _init();
  }

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

}

import 'package:app_pagos/models/tarjeta_credito.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(PagarState()) {

/*
    @override 
    Stream<PagarState> mapEventToState ( PagarEvent event) async* {
      /*
      if( event is OnSeleccionartarjeta){
        yield state.copyWith( tarjetaActiva:  true, tarjeta: event.tarjeta);
      }else if (event is OnDesactivarTarjeta ){
        yield state.copyWith( tarjetaActiva : true);
      }
      */
    }
*/
    on<OnSeleccionartarjeta>( (event, emit) => emit(state.copyWith(tarjetaActiva:  true, tarjeta: event.tarjeta))  ) ;
    on<OnDesactivarTarjeta>( (event, emit) => emit( state.copyWith(tarjetaActiva : false)) );
  }
}

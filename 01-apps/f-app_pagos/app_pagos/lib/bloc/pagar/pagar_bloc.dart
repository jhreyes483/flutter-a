import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(PagarInitial()) {
    on<PagarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

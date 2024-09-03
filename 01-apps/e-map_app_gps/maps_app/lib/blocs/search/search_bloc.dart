import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchEvent>((event, emit) {
    
    on<OnActivateManualMarkerEvent>(_onActivateDestino );
    });

    // OnActivateManualMarkerEvent
  }

  void _onActivateDestino(OnActivateManualMarkerEvent event, Emitter<SearchState> emit){
    print('_onActivateDestino');
    emit(state.copyWith(displayManualMarker: true));
    print(state);
  }
}

part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];

}


class OnActivateManualMarkerEvent extends SearchEvent {}

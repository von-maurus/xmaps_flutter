part of 'search_destination_bloc.dart';

sealed class SearchDestinationEvent extends Equatable {
  const SearchDestinationEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchDestinationEvent {
  const OnActivateManualMarkerEvent();

  @override
  List<Object> get props => [];
}

class OnDeactivateManualMarkerEvent extends SearchDestinationEvent {
  const OnDeactivateManualMarkerEvent();

  @override
  List<Object> get props => [];
}

class OnNewPlacesEvent extends SearchDestinationEvent {
  final List<Feature> places;

  const OnNewPlacesEvent({required this.places});
}

class OnAddToHistoryEvent extends SearchDestinationEvent {
  final Feature place;

  const OnAddToHistoryEvent({required this.place});
}

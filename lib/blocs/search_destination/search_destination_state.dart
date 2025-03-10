part of 'search_destination_bloc.dart';

class SearchDestinationState extends Equatable {
  final bool displayManualMarker;
  final List<Feature> places;
  final List<Feature> history;
  const SearchDestinationState({
    this.displayManualMarker = false,
    this.places = const [],
    this.history = const [],
  });

  SearchDestinationState copyWith({bool? displayManualMarker, List<Feature>? places, List<Feature>? history}) {
    return SearchDestinationState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker,
      places: places ?? this.places,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [displayManualMarker, places, history];
}

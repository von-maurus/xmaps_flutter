part of 'search_destination_bloc.dart';

class SearchDestinationState extends Equatable {
  final bool displayManualMarker;

  const SearchDestinationState({this.displayManualMarker = false});

  SearchDestinationState copyWith({bool? displayManualMarker}) {
    return SearchDestinationState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker,
    );
  }

  @override
  List<Object> get props => [displayManualMarker];
}

part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialized extends MapEvent {
  final GoogleMapController controller;

  const OnMapInitialized(this.controller);

  @override
  List<Object> get props => [controller];
}

class OnStartFollowingUser extends MapEvent {
  const OnStartFollowingUser();
}

class OnStopFollowingUser extends MapEvent {
  const OnStopFollowingUser();
}

class UpdateUserPolylines extends MapEvent {
  final List<LatLng> userLocations;

  const UpdateUserPolylines(this.userLocations);

  @override
  List<Object> get props => [userLocations];
}

class OnToggleUserRoute extends MapEvent {}

class OnNewRoute extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const OnNewRoute(this.polylines, this.markers);
}

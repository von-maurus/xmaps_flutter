part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool followUser;
  final bool showMyRoute;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapState({
    this.isMapInitialized = false,
    this.followUser = false,
    this.polylines = const {},
    this.showMyRoute = true,
    this.markers = const {},
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    bool? showMyRoute,
  }) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      followUser: followUser ?? this.followUser,
      polylines: polylines ?? this.polylines,
      markers: markers ?? this.markers,
      showMyRoute: showMyRoute ?? this.showMyRoute,
    );
  }

  @override
  List<Object> get props => [isMapInitialized, followUser, polylines, showMyRoute, markers];
}

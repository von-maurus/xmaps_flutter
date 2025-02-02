part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool followUser;
  final bool showMyRoute;
  final Map<PolylineId, Polyline> polylines;

  const MapState({
    this.isMapInitialized = false,
    this.followUser = false,
    this.polylines = const {},
    this.showMyRoute = true,
  });

  MapState copyWith(
      {bool? isMapInitialized, bool? followUser, Map<PolylineId, Polyline>? polylines, bool? showMyRoute}) {
    return MapState(
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      followUser: followUser ?? this.followUser,
      polylines: polylines ?? this.polylines,
      showMyRoute: showMyRoute ?? this.showMyRoute,
    );
  }

  @override
  List<Object> get props => [isMapInitialized, followUser, polylines, showMyRoute];
}

part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool isTracking;
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;
  LocationState({
    this.isTracking = false,
    this.lastKnownLocation,
    locationHistory,
  }) : locationHistory = locationHistory ?? [];

  @override
  List<Object?> get props => [isTracking, lastKnownLocation, locationHistory];

  LocationState copyWith({
    bool? isTracking,
    LatLng? lastKnownLocation,
    List<LatLng>? locationHistory,
  }) {
    return LocationState(
      isTracking: isTracking ?? this.isTracking,
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      locationHistory: locationHistory ?? this.locationHistory,
    );
  }
}

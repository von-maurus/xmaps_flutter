part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class UserLocationEvent extends LocationEvent {
  final LatLng lastKnownLocation;
  // final List<LatLng> locationHistory;

  const UserLocationEvent({
    required this.lastKnownLocation,
    // required this.locationHistory,
  });

  @override
  List<Object> get props => [lastKnownLocation];
}

class StartTrackingEvent extends LocationEvent {}

class StopTrackingEvent extends LocationEvent {}

class UpdateLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const UpdateLocationEvent({
    required this.newLocation,
  });

  @override
  List<Object> get props => [newLocation];
}

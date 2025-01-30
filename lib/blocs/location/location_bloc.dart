import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _positionSubscription;
  LocationBloc() : super(LocationState()) {
    on<UserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnownLocation: event.lastKnownLocation,
        locationHistory: [...state.locationHistory, event.lastKnownLocation],
      ));
    });
    on<StartTrackingEvent>((event, emit) {
      emit(state.copyWith(isTracking: true));
    });

    on<StopTrackingEvent>((event, emit) {
      emit(state.copyWith(isTracking: false));
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    add(UserLocationEvent(lastKnownLocation: LatLng(position.latitude, position.longitude)));
    return position;
  }

  void startTracking() {
    try {
      add(StartTrackingEvent());
      _positionSubscription = Geolocator.getPositionStream().listen((Position position) {
        print('Start tracking: $position');
        add(UserLocationEvent(lastKnownLocation: LatLng(position.latitude, position.longitude)));
      });
    } catch (e) {
      print("Error: [startTracking] $e");
    }
  }

  void stopTracking() {
    try {
      add(StopTrackingEvent());
      _positionSubscription?.cancel();
    } catch (e) {
      print("Error: [stopTracking] $e");
    }
  }

  @override
  Future<void> close() {
    stopTracking();
    return super.close();
  }
}

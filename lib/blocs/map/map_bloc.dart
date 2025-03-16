import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/models/models.dart';
import 'package:xmaps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  StreamSubscription<LocationState>? locationSubscription;
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  String _mapStyle = '';
  LatLng? mapCenter;

  String get mapStyle => _mapStyle;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialized>(_initMap);

    on<OnStartFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: true));
    });

    on<OnStopFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: false));
    });

    on<UpdateUserPolylines>(_updatePolylines);

    on<OnToggleUserRoute>((event, emit) {
      emit(state.copyWith(showMyRoute: !state.showMyRoute));
    });

    on<OnNewRoute>((event, emit) {
      emit(state.copyWith(polylines: event.polylines, markers: event.markers));
    });

    // Listen to user location
    locationSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylines(locationState.locationHistory));
      }

      if (!state.followUser) return;
      if (locationState.lastKnownLocation == null) return;

      moveCamera(locationState.lastKnownLocation!);
    });
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }

  void _initMap(OnMapInitialized event, Emitter emitter) {
    _mapController = event.controller;
    _mapStyle = jsonEncode(interfaceMap);
    emitter(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng target) {
    final cameraUpdate = CameraUpdate.newLatLng(target);
    _mapController?.animateCamera(cameraUpdate);
  }

  void _updatePolylines(UpdateUserPolylines event, Emitter<MapState> emit) {
    final polyline = Polyline(
      width: 5,
      points: event.userLocations,
      color: Colors.blue,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      polylineId: const PolylineId('myRoute'),
    );
    final currentPolylines = Map<String, Polyline>.from(state.polylines);

    currentPolylines['myRoute'] = polyline;
    emit(state.copyWith(polylines: currentPolylines));
  }

  Future<void> drawRouteDestination(RouteDestination destination) async {
    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 6,
    );
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = polyline;

    final double kms = (((destination.distance / 1000) * 100).floorToDouble()) / 100;
    final tripDuration = (destination.duration / 60).floorToDouble();
    final marker = Marker(
      markerId: const MarkerId('start'),
      position: destination.points.first,
      infoWindow: InfoWindow(title: 'Inicio', snippet: 'Duración: $tripDuration, KMs: $kms'),
    );
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      infoWindow: InfoWindow(title: destination.endPlace.text, snippet: destination.endPlace.placeName),
    );
    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = marker;
    currentMarkers['end'] = endMarker;
    add(OnNewRoute(currentPolylines, currentMarkers));

    // await Future.delayed(const Duration(milliseconds: 300));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));
  }
}

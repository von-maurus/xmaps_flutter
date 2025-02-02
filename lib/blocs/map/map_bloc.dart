import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late final StreamSubscription<LocationState> locationSubscription;
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  String _mapStyle = '';
  String get mapStyle => _mapStyle;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialized>(_initMap);

    on<OnStartFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: true));
    });

    on<OnStopFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: false));
    });

    on<UpdateUserPolylines>((event, emit) {
      final newPolys = updatePolylines(event.userLocations);
      emit(state.copyWith(polylines: newPolys));
    });

    on<OnToggleUserRoute>((event, emit) {
      print(state.showMyRoute);
      emit(state.copyWith(showMyRoute: !state.showMyRoute));
    });

    // Listen to user location
    locationSubscription = locationBloc.stream.listen((event) {
      if (event.lastKnownLocation != null) {
        add(UpdateUserPolylines(event.locationHistory));
      }
      if (event.lastKnownLocation != null && state.followUser) {
        moveCamera(event.lastKnownLocation!);
      }
    });
  }

  @override
  Future<void> close() {
    locationSubscription.cancel();
    return super.close();
  }

  void _initMap(OnMapInitialized event, Emitter emitter) {
    _mapController = event.controller;
    _mapStyle = jsonEncode(gmapsDarkTheme);
    emitter(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng target) {
    final cameraUpdate = CameraUpdate.newLatLng(target);
    _mapController?.animateCamera(cameraUpdate);
  }

  Map<PolylineId, Polyline> updatePolylines(List<LatLng> points) {
    final polyline = Polyline(
      width: 5,
      points: points,
      color: Colors.blue,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      polylineId: const PolylineId('myNewRoute'),
    );
    final currentPolylines = Map<PolylineId, Polyline>.from(state.polylines);
    currentPolylines[polyline.polylineId] = polyline;
    return currentPolylines;
  }
}

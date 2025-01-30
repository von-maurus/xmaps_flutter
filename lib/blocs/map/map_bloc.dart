import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _mapController;
  String _mapStyle = '';
  String get mapStyle => _mapStyle;

  MapBloc() : super(const MapState()) {
    on<OnMapInitialized>(_initMap);
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
}

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:xmaps_app/models/models.dart';
import 'package:xmaps_app/services/services.dart';

part 'search_destination_event.dart';
part 'search_destination_state.dart';

class SearchDestinationBloc extends Bloc<SearchDestinationEvent, SearchDestinationState> {
  TrafficService trafficService;
  SearchDestinationBloc({required this.trafficService}) : super(const SearchDestinationState()) {
    on<OnActivateManualMarkerEvent>((event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnDeactivateManualMarkerEvent>((event, emit) => emit(state.copyWith(displayManualMarker: false)));
    on<OnNewPlacesEvent>((event, emit) => emit(state.copyWith(places: event.places)));
    on<OnAddToHistoryEvent>((event, emit) {
      final history = List.of(state.history)..insert(0, event.place);
      emit(state.copyWith(history: history));
    });
  }

  Future<RouteDestination> getNewRoute(LatLng start, LatLng end) async {
    final res = await trafficService.getLatLong(start, end);
    final distance = res.routes[0].distance;
    final duration = res.routes[0].duration;
    final geometry = res.routes[0].geometry;
    final List<PointLatLng> result = PolylinePoints().decodePolyline(geometry);
    final points = result.map((point) => LatLng(point.latitude, point.longitude)).toList();

    return RouteDestination(points: points, duration: duration, distance: distance);
  }

  Future<void> getPlacesByQuery(LatLng proximity, String query) async {
    final places = await trafficService.getResultsByQuery(proximity, query);
    add(OnNewPlacesEvent(places: places));
  }
}

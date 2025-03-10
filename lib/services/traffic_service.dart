import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/models/models.dart';
import 'package:xmaps_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;
  final String _baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl = 'https://api.mapbox.com/search/geocode/v6/forward';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getLatLong(LatLng start, LatLng end) async {
    final coordinates = "${start.longitude}, ${start.latitude}; ${end.longitude}, ${end.latitude}";
    final endpoint = "$_baseUrl/driving/$coordinates";
    final response = await _dioTraffic.get(endpoint);
    final parsing = TrafficResponse.fromMap(response.data);
    return parsing;
  }

  Future<List<Feature>> getResultsByQuery(LatLng proximity, String query) async {
    if (query.isEmpty) return [];
    final res = await _dioPlaces.get(
      _basePlacesUrl,
      queryParameters: {'q': query, 'proximity': '${proximity.longitude}, ${proximity.latitude}'},
    );
    final places = PlacesResponse.fromMap(res.data);
    return places.features;
  }
}

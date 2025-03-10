import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/models/models.dart';
import 'package:xmaps_app/services/services.dart';

class TrafficService {
  final Dio _dio = Dio()..interceptors.add(TrafficInterceptor());
  final String _baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  TrafficService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 3); // 3 seconds
  }

  Future<TrafficResponse> getLatLong(LatLng start, LatLng end) async {
    final coordinates = "${start.longitude}, ${start.latitude}; ${end.longitude}, ${end.latitude}";
    final endpoint = "/driving/$coordinates";
    final response = await _dio.get(endpoint);
    final parsing = TrafficResponse.fromMap(response.data);
    return parsing;
  }

  Future<Response> getTrafficData(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      // Handle error
      print('Error: $e');
      throw e;
    }
  }

  Future<Response> postTrafficData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      // Handle error
      print('Error: $e');
      throw e;
    }
  }
}

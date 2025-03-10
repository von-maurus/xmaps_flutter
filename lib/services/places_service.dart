import 'package:dio/dio.dart';

class PlacesService {
  final Dio _dio;

  PlacesService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.example.com', // Replace with your base URL
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add any request interceptors here
        print('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Add any response interceptors here
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Add any error interceptors here
        print('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> getPlace(String placeId) async {
    try {
      final response = await _dio.get('/places/$placeId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchPlaces(String query) async {
    try {
      final response = await _dio.get('/places', queryParameters: {'query': query});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

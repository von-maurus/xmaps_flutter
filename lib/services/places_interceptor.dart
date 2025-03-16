import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final token = "pk.eyJ1IjoibXNhbnoiLCJhIjoiY203NHpnaW9jMGd4cjJqcHowMTRhc3RoaCJ9.xg9MDZv9G_jdzf_85kQSKA";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': token,
      'language': 'es',
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle the response if needed
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException except, ErrorInterceptorHandler handler) {
    // Handle the error if needed
    super.onError(except, handler);
  }
}

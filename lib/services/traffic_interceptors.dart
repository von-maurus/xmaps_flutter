import 'package:dio/dio.dart';

const token = "pk.eyJ1IjoibXNhbnoiLCJhIjoiY203NHptazVrMDZkaTJqcHJoaXBvbXFrcSJ9.jO65-CEVP9p71D7OxeWSEw";

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add any custom request logic here
    options.queryParameters['access_token'] = token;
    options.queryParameters['alternatives'] = true;
    options.queryParameters['geometries'] = "polyline6";
    options.queryParameters['overview'] = "simplified";
    options.queryParameters['steps'] = false;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Add any custom response logic here
    print('Response: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Add any custom error handling logic here
    print('Error: ${err.message}');
    super.onError(err, handler);
  }
}

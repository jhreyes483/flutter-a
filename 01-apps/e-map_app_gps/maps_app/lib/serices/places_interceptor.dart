import 'package:dio/dio.dart';
import 'package:maps_app/serices/traffic_interceptor.dart';

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /*
    Agregar parametros como un form
    */

    options.queryParameters.addAll({
      'access_token': accessToken,
      'lenguage': 'es',
      'limit':7,
    });
    super.onRequest(options, handler);
  }
}
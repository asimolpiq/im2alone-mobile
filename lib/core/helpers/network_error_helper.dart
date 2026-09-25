import 'package:dio/dio.dart';

class NetworkErrorHelper {
  static String keyFor(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.transformTimeout:
          return 'network_timeout_error';
        case DioExceptionType.connectionError:
          return 'network_connection_error';
        case DioExceptionType.badResponse:
          return 'network_server_error';
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          return 'network_unknown_error';
      }
    }
    return 'network_unknown_error';
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';

import '../../product/config/config.dart';

class RequestHelper with CachingManager {
  static final _dio = Dio();
  static RequestHelper _requestHelper = RequestHelper._internal();

  RequestHelper._createInstance();

  factory RequestHelper() {
    return _requestHelper;
  }

  RequestHelper._internal() {
    _requestHelper = RequestHelper._createInstance();
  }

  Dio get dio {
    _dio.options.baseUrl = Config['BASE_API_URL'];
    _dio.options.connectTimeout = const Duration(seconds: 10); //5s
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['X-Requested-With'] = 'XMLHttpRequest';

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        var token = await getToken();
        if (token != null) {
          options.headers.putIfAbsent('Authorization', () => token);
        }

        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) async {
        if (response.data != null && response.data.runtimeType == String) {
          var data = jsonDecode(response.data);
          if (data["error"].toString() == "unauthorized") {
            removeToken();
            // Diğer işlemler
          }
        }
        return handler.next(response); // continue
      },
      onError: (e, ErrorInterceptorHandler handler) {
        return handler.next(e);
      },
    ));

    return _dio;
  }
}

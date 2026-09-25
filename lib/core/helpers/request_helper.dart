import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/product/components/snackbar/custom_snacbars.dart';
import 'package:im2alone/views/auth/login/login_view.dart';

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

  void _handleExpiredSession() {
    if (!Get.isRegistered<AuthController>(tag: "authmanager")) {
      return;
    }
    final AuthController authController = Get.find(tag: "authmanager");
    if (!authController.isLogin.value) {
      return;
    }
    authController.logout();
    Get.offAll(() => const LoginView());
    Get.showSnackbar(
        CustomSnackbars.errorSnack(error: 'session_expired'.tr));
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
        final data = response.data;
        if (data is Map && data["data"].toString() == "unauthorized") {
          removeToken();
        }
        if (data is Map &&
            (data['error'] == 'Authorization error!' ||
                data['data'] == 'Authorization error!')) {
          _handleExpiredSession();
        }
        return handler.next(response);
      },
      onError: (e, ErrorInterceptorHandler handler) {
        return handler.next(e);
      },
    ));

    return _dio;
  }
}

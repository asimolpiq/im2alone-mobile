import 'package:dio/dio.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/core/helpers/network_error_helper.dart';
import 'package:im2alone/model/auth/login_request_model.dart';
import 'package:im2alone/model/auth/login_response_model.dart';
import 'package:im2alone/model/auth/register_model.dart';
import 'package:im2alone/model/auth/register_response_model.dart';

abstract class IAuthService {
  final Dio dio;
  final String loginPath = '/login.php';
  final String getUserPath = '/get-user.php';
  final String registerPath = '/register.php';
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel);
  Future<LoginResponseModel> getUser();
  Future<RegisterResponseModel> register(RegisterModel user);
  IAuthService(this.dio);
}

class AuthService extends IAuthService with CachingManager {
  AuthService(dio) : super(dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await dio.post(loginPath, data: loginRequestModel);
      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['error'] == null) {
          return LoginResponseModel.fromJson(parsedData);
        } else {
          return LoginResponseModel.withError(parsedData['error']);
        }
      } else {
        return LoginResponseModel.withError('network_server_error');
      }
    } catch (e) {
      return LoginResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<LoginResponseModel> getUser() async {
    try {
      final response = await dio.post(
        getUserPath,
      );

      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['error'] == null) {
          return LoginResponseModel.fromJson(parsedData);
        } else {
          return LoginResponseModel.withError(parsedData['error']);
        }
      } else {
        return LoginResponseModel.withError('network_server_error');
      }
    } catch (e) {
      return LoginResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<RegisterResponseModel> register(RegisterModel user) async {
    try {
      final response = await dio.post(
        registerPath,
        data: user,
      );

      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['error'] == null) {
          return RegisterResponseModel.fromJson(parsedData);
        } else {
          return RegisterResponseModel.withError(parsedData['data']);
        }
      } else {
        return RegisterResponseModel.withError('network_server_error');
      }
    } catch (e) {
      return RegisterResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }
}

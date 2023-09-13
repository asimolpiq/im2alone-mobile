import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/model/auth/login_request_model.dart';
import 'package:im2alone/model/auth/login_response_model.dart';

abstract class IAuthService {
  final Dio dio;
  final String loginPath = '/login.php';
  final String getUserPath = '/get-user.php';
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel);
  Future<LoginResponseModel> getUser();
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
        LoginResponseModel.withError(response.data['error']);
      }
    } catch (e) {
      log(e.toString());
      return LoginResponseModel.withError(e.toString());
    }
    return LoginResponseModel.withError('-');
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
        LoginResponseModel.withError(response.data['error']);
      }
    } catch (e) {
      log(e.toString());
      return LoginResponseModel.withError(e.toString());
    }
    return LoginResponseModel.withError('-');
  }
}

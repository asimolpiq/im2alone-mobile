import 'user_model.dart';

class LoginResponseModel {
  User? user;
  String? error;

  LoginResponseModel({this.user, this.error});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['data']);
    error = null;
  }

  LoginResponseModel.withError(String errorValue)
      : user = null,
        error = errorValue;
}

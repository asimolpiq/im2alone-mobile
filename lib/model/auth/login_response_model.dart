import 'user_model.dart';

class LoginResponseModel {
  User? user;
  String? error;

  LoginResponseModel({this.user, this.error});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    user = User.fromJson(data is Map<String, dynamic> ? data : null);
    error = null;
  }

  LoginResponseModel.withError(String errorValue)
      : user = null,
        error = errorValue;
}

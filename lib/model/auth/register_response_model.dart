class RegisterResponseModel {
  String? token;
  String? error;

  RegisterResponseModel({this.token, this.error});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    error = null;
  }

  RegisterResponseModel.withError(String errorValue)
      : token = null,
        error = errorValue;
}

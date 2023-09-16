import '../auth/user_model.dart';

class SearchResponseModel {
  List<User>? users;
  String? error;

  SearchResponseModel({this.users, this.error});

  SearchResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      users = <User>[];
      json['data'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    error = null;
  }

  SearchResponseModel.withError(String errorValue)
      : users = null,
        error = errorValue;
}

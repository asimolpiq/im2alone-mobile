import 'blocked_user_model.dart';

class BlockedUsersResponseModel {
  List<BlockedUserModel>? blockedUsers;
  String? error;

  BlockedUsersResponseModel({this.blockedUsers, this.error});

  BlockedUsersResponseModel.fromJson(Map<String, dynamic> json) {
    blockedUsers = <BlockedUserModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        blockedUsers!.add(BlockedUserModel.fromJson(v));
      });
    }
    error = null;
  }

  BlockedUsersResponseModel.withError(String errorValue)
      : blockedUsers = null,
        error = errorValue;
}

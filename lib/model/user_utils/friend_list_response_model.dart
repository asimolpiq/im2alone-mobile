import 'friend_list_model.dart';

class FriendListResponseModel {
  List<FriendListModel>? friends;
  String? error;

  FriendListResponseModel({this.friends, this.error});

  FriendListResponseModel.fromJson(Map<String, dynamic> json) {
    friends = <FriendListModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        friends!.add(FriendListModel.fromJson(v));
      });
    }
    error = null;
  }

  FriendListResponseModel.withError(String errorValue)
      : friends = null,
        error = errorValue;
}

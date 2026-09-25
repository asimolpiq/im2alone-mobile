import 'package:dio/dio.dart';

import 'package:im2alone/core/helpers/network_error_helper.dart';
import 'package:im2alone/model/user_utils/blocked_users_response_model.dart';
import 'package:im2alone/model/user_utils/friend_list_response_model.dart';
import 'package:im2alone/model/user_utils/notification_response_model.dart';
import 'package:im2alone/model/user_utils/search_response_model.dart';
import 'package:im2alone/model/user_utils/user_stats_response_model.dart';

abstract class IUserService {
  final Dio dio;
  final String userStatsPath = '/user-stats.php';
  final String searchPath = '/search.php';
  final String editProfilePath = '/edit-profile.php';
  final String changePasswordPath = '/change-password.php';
  final String addFriendPath = '/add-friend.php';
  final String deleteFriendPath = '/delete-friend.php';
  final String notificationPath = '/get-notification.php';
  final String acceptFriendPath = '/accept-friend.php';
  final String ignoreFriendPath = '/ignore-user.php';
  final String blockUserPath = '/block-user.php';
  final String unblockUserPath = '/unblock-user.php';
  final String getBlockedUsersPath = '/get-blocked-users.php';
  final String reportContentPath = '/report-content.php';
  final String getFollowersPath = '/get-followers.php';
  final String getFollowingPath = '/get-following.php';
  final String uploadAvatarPath = '/upload-avatar.php';
  Future<UserStatsResponseModel> getStats(String id);
  Future<SearchResponseModel> search(String query);
  Future<bool> editProfile(String username, String fullname, String bio,
      String email, String gender, String birthday);
  Future<bool> changePassword(String newPassword);
  Future<bool> addFriend(String friendID);
  Future<bool> deleteFriend(String friendID);
  Future<bool> acceptFriend(String friendID);
  Future<bool> ignoreFriend(String friendID);
  Future<NotificationResponseModel> getNotifications();
  Future<bool> blockUser(String userID);
  Future<bool> unblockUser(String userID);
  Future<BlockedUsersResponseModel> getBlockedUsers();
  Future<bool> reportContent(
      {required String reportedUserID,
      String? feedID,
      required String reason,
      String? description});
  Future<FriendListResponseModel> getFollowers();
  Future<FriendListResponseModel> getFollowing();
  Future<String?> uploadAvatar(String filePath);

  IUserService(this.dio);
}

class UserService extends IUserService {
  UserService(dio) : super(dio);

  @override
  Future<UserStatsResponseModel> getStats(String id) async {
    try {
      final response = await dio.post(userStatsPath, data: {'userID': id});
      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['error'] == null) {
          return UserStatsResponseModel.fromJson(parsedData);
        } else {
          return UserStatsResponseModel.withError(parsedData['error']);
        }
      } else {
        return UserStatsResponseModel.withError('network_server_error');
      }
    } catch (e) {
      return UserStatsResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<SearchResponseModel> search(String query) async {
    try {
      final response = await dio.post(searchPath, data: {'searchText': query});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return SearchResponseModel.withError(parsedData['data']);
        } else {
          return SearchResponseModel.fromJson(parsedData);
        }
      } else {
        return SearchResponseModel.withError('network_server_error');
      }
    } catch (e) {
      return SearchResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<bool> editProfile(String username, String fullname, String bio,
      String email, String gender, String birthday) async {
    try {
      final response = await dio.post(editProfilePath, data: {
        "username": username,
        "fullname": fullname,
        "bio": bio,
        "email": email,
        "gender": gender,
        "birthday": birthday,
      });
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> changePassword(String newPassword) async {
    try {
      final response = await dio
          .post(changePasswordPath, data: {"new_password": newPassword});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> addFriend(String friendID) async {
    try {
      final response =
          await dio.post(addFriendPath, data: {"friendID": friendID});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteFriend(String friendID) async {
    try {
      final response =
          await dio.post(deleteFriendPath, data: {"friendID": friendID});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<NotificationResponseModel> getNotifications() async {
    try {
      final response = await dio.post(notificationPath);
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return NotificationResponseModel.withError(parsedData['data']);
        } else {
          return NotificationResponseModel.fromJson(parsedData);
        }
      } else {
        return NotificationResponseModel.withError('network_server_error');
      }
    } catch (e) {
      return NotificationResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<bool> acceptFriend(String friendID) async {
    try {
      final response =
          await dio.post(acceptFriendPath, data: {"friendID": friendID});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> ignoreFriend(String friendID) async {
    try {
      final response =
          await dio.post(ignoreFriendPath, data: {"friendID": friendID});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> blockUser(String userID) async {
    try {
      final response = await dio.post(blockUserPath, data: {"userID": userID});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        return parsedData['status'] != "error";
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unblockUser(String userID) async {
    try {
      final response =
          await dio.post(unblockUserPath, data: {"userID": userID});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        return parsedData['status'] != "error";
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BlockedUsersResponseModel> getBlockedUsers() async {
    try {
      final response = await dio.post(getBlockedUsersPath);
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return BlockedUsersResponseModel.withError(parsedData['data'] ?? '-');
        } else {
          return BlockedUsersResponseModel.fromJson(parsedData);
        }
      }
      return BlockedUsersResponseModel.withError('network_server_error');
    } catch (e) {
      return BlockedUsersResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<bool> reportContent({
    required String reportedUserID,
    String? feedID,
    required String reason,
    String? description,
  }) async {
    try {
      final response = await dio.post(reportContentPath, data: {
        "reportedUserID": reportedUserID,
        "feedID": feedID,
        "reason": reason,
        "description": description,
      });
      if (response.statusCode == 200) {
        final parsedData = response.data;
        return parsedData['status'] != "error";
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<FriendListResponseModel> getFollowers() async {
    try {
      final response = await dio.post(getFollowersPath);
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return FriendListResponseModel.withError(parsedData['data'] ?? '-');
        } else {
          return FriendListResponseModel.fromJson(parsedData);
        }
      }
      return FriendListResponseModel.withError('network_server_error');
    } catch (e) {
      return FriendListResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<FriendListResponseModel> getFollowing() async {
    try {
      final response = await dio.post(getFollowingPath);
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "error") {
          return FriendListResponseModel.withError(parsedData['data'] ?? '-');
        } else {
          return FriendListResponseModel.fromJson(parsedData);
        }
      }
      return FriendListResponseModel.withError('network_server_error');
    } catch (e) {
      return FriendListResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<String?> uploadAvatar(String filePath) async {
    try {
      final formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(filePath),
      });
      final response = await dio.post(uploadAvatarPath, data: formData);
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "success") {
          return parsedData['data']['pp'] as String?;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

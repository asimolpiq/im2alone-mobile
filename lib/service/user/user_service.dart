import 'package:dio/dio.dart';
import 'package:im2alone/model/user_utils/search_response_model.dart';
import 'package:im2alone/model/user_utils/user_stats_response_model.dart';

abstract class IUserService {
  final Dio dio;
  final String userStatsPath = '/user-stats.php';
  final String searchPath = '/search.php';
  final String editProfilePath = '/edit-profile.php';
  final String changePasswordPath = '/change-password.php';
  Future<UserStatsResponseModel> getStats(String id);
  Future<SearchResponseModel> search(String query);
  Future<bool> editProfile(String username, String fullname, String bio);
  Future<bool> changePassword(String newPassword);

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
        UserStatsResponseModel.withError(response.data['error']);
      }
    } catch (e) {
      return UserStatsResponseModel.withError(e.toString());
    }
    return UserStatsResponseModel.withError('-');
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
        UserStatsResponseModel.withError(response.data['data']);
      }
    } catch (e) {
      return SearchResponseModel.withError(e.toString());
    }
    return SearchResponseModel.withError('-');
  }

  @override
  Future<bool> editProfile(String username, String fullname, String bio) async {
    try {
      final response = await dio.post(editProfilePath, data: {"username": username, "fullname": fullname, "bio": bio});
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
      final response = await dio.post(changePasswordPath, data: {"new_password": newPassword});
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
}
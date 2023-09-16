import 'package:dio/dio.dart';
import 'package:im2alone/model/user_utils/search_response_model.dart';
import 'package:im2alone/model/user_utils/user_stats_response_model.dart';

abstract class IUserService {
  final Dio dio;
  final String userStatsPath = '/user-stats.php';
  final String searchPath = '/search.php';
  Future<UserStatsResponseModel> getStats(String id);
  Future<SearchResponseModel> search(String query);

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
}

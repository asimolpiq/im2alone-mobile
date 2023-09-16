import 'user_stats_model.dart';

class UserStatsResponseModel {
  UserStatsModel? userStats;
  String? error;

  UserStatsResponseModel({this.userStats, this.error});

  UserStatsResponseModel.fromJson(Map<String, dynamic> json) {
    userStats = UserStatsModel.fromJson(json['data']);
    error = null;
  }

  UserStatsResponseModel.withError(String errorValue)
      : userStats = null,
        error = errorValue;
}

import '../../core/helpers/request_helper.dart';
import '../../model/user_utils/user_stats_response_model.dart';
import '../../service/user/user_service.dart';

mixin GetUserStats {
  final UserService _userService = UserService(RequestHelper().dio);
  Future<UserStatsResponseModel> getUserStats(String id) async {
    try {
      final response = await _userService.getStats(id);
      if (response.error == null) {
        return response;
      } else {
        return UserStatsResponseModel.withError(response.error!);
      }
    } catch (e) {
      return UserStatsResponseModel.withError(e.toString());
    }
  }
}

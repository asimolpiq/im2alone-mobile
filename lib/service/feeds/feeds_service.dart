import 'package:dio/dio.dart';

import '../../core/helpers/network_error_helper.dart';
import '../../model/feeds/feeds_response_model.dart';
import '../../model/feeds/like_toggle_result.dart';

abstract class IFeedsService {
  final Dio dio;
  final String myDiaryPath = '/my-diary.php';
  final String allDiaryPath = '/all-feeds.php';
  final String deleteDiaryPath = '/delete-diary.php';
  final String writeDiaryPath = '/write-diary.php';
  final String likePostPath = '/like-post.php';
  IFeedsService(this.dio);
  Future<FeedsResponseModel> getMyDiary();
  Future<FeedsResponseModel> getAllDiary();
  Future<bool> deleteDiary(String id);
  Future<bool> writeDiary(
      {required String content, required String link, required String privacy});
  Future<LikeToggleResult> toggleLike(String feedId);
}

class FeedsService extends IFeedsService {
  FeedsService(Dio dio) : super(dio);

  @override
  Future<FeedsResponseModel> getMyDiary() async {
    try {
      final response = await dio.post(myDiaryPath);
      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['status'] == "success") {
          return FeedsResponseModel.fromJson(parsedData);
        } else {
          return FeedsResponseModel.withError(parsedData['data']);
        }
      }
      return FeedsResponseModel.withError('network_server_error');
    } catch (e) {
      return FeedsResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<FeedsResponseModel> getAllDiary() async {
    try {
      final response = await dio.post(allDiaryPath);
      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['status'] == "success") {
          return FeedsResponseModel.fromJson(parsedData);
        } else {
          return FeedsResponseModel.withError(parsedData['error']);
        }
      }
      return FeedsResponseModel.withError('network_server_error');
    } catch (e) {
      return FeedsResponseModel.withError(NetworkErrorHelper.keyFor(e));
    }
  }

  @override
  Future<bool> deleteDiary(String id) async {
    try {
      final response = await dio.post(deleteDiaryPath, data: {"id": id});
      if (response.statusCode == 200) {
        final parsedData = response.data;

        if (parsedData['status'] == "success") {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> writeDiary(
      {required String content,
      required String link,
      required String privacy}) async {
    try {
      final response = await dio.post(writeDiaryPath, data: {
        "content": content,
        "link": link,
        "privacy": privacy,
      });
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "success") {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<LikeToggleResult> toggleLike(String feedId) async {
    try {
      final response = await dio.post(likePostPath, data: {"feedID": feedId});
      if (response.statusCode == 200) {
        final parsedData = response.data;
        if (parsedData['status'] == "success") {
          return LikeToggleResult(
            success: true,
            liked: parsedData['data']['liked'] == true,
            count: parsedData['data']['count'] as int? ?? 0,
          );
        }
      }
      return LikeToggleResult(success: false, liked: false, count: 0);
    } catch (e) {
      return LikeToggleResult(success: false, liked: false, count: 0);
    }
  }
}

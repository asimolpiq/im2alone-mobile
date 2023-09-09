import 'package:dio/dio.dart';

import '../../model/feeds/feeds_response_model.dart';

abstract class IFeedsService {
  final Dio dio;
  final String myDiaryPath = '/my-diary.php';
  final String allDiaryPath = '/all-feeds.php';
  final String deleteDiaryPath = '/delete-diary.php';
  IFeedsService(this.dio);
  Future<FeedsResponseModel> getMyDiary();
  Future<FeedsResponseModel> getAllDiary();
  Future<bool> deleteDiary(String id);
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
      return FeedsResponseModel.fromJson(response.data);
    } catch (e) {
      return FeedsResponseModel.withError(e.toString());
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
      return FeedsResponseModel.fromJson(response.data);
    } catch (e) {
      return FeedsResponseModel.withError(e.toString());
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
}

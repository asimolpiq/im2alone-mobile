import 'package:dio/dio.dart';

import '../../model/feeds/feeds_response_model.dart';

abstract class IFeedsService {
  final Dio dio;
  final String myDiaryPath = "my-diary.php";
  IFeedsService({required this.dio});
  Future<FeedsResponseModel> getMyDiary();
}

class FeedsService extends IFeedsService {
  FeedsService({required Dio dio}) : super(dio: dio);

  @override
  Future<FeedsResponseModel> getMyDiary() async {
    try {
      final response = await dio.get(myDiaryPath);
      return FeedsResponseModel.fromJson(response.data);
    } catch (e) {
      return FeedsResponseModel.withError(e.toString());
    }
  }
}

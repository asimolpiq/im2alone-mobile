import 'package:im2alone/model/feeds/feeds_model.dart';

class FeedsResponseModel {
  List<FeedsModel>? feeds;
  String? error;

  FeedsResponseModel({this.feeds, this.error});

  FeedsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    feeds = data is List
        ? data
            .whereType<Map<String, dynamic>>()
            .map((e) => FeedsModel.fromJson(e))
            .toList()
        : <FeedsModel>[];
    error = null;
  }

  FeedsResponseModel.withError(String errorValue)
      : feeds = null,
        error = errorValue;
}

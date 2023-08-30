import 'package:im2alone/model/feeds/feeds_model.dart';

class FeedsResponseModel {
  List<FeedsModel>? feeds;
  String? error;

  FeedsResponseModel({this.feeds, this.error});

  FeedsResponseModel.fromJson(Map<String, dynamic> json) {
    feeds = (json['data'] as List).map((e) => FeedsModel.fromJson(e)).toList();
    error = null;
  }

  FeedsResponseModel.withError(String errorValue)
      : feeds = null,
        error = errorValue;
}

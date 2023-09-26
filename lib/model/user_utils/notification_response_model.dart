import 'notification_model.dart';

class NotificationResponseModel {
  List<NotificationModel>? notifications;
  String? error;

  NotificationResponseModel({
    this.notifications,
    this.error,
  });

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    notifications = List<NotificationModel>.from(json['data'].map((e) => NotificationModel.fromJson(e)));
    error = null;
  }

  NotificationResponseModel.withError(String errorValue)
      : notifications = null,
        error = errorValue;
}

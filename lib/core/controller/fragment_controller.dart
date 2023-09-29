import 'package:get/get.dart';
import 'package:im2alone/product/enums/project_enums.dart';

import '../../model/user_utils/notification_model.dart';

class FragmentController extends GetxController {
  Rx<AuthStates> authState = AuthStates.myAccount.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
}

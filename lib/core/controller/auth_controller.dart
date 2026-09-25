import 'package:get/get.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/core/helpers/diary_sync_manager.dart';

import '../../model/auth/user_model.dart';

class AuthController extends GetxController
    with CachingManager, DiarySyncManager {
  RxBool isLogin = false.obs;
  Rx<User> currentUser = User().obs;

  logout() {
    isLogin.value = false;
    currentUser.value = User();
    flushPendingDiaries().then((_) {
      removeToken();
      removeCachedUser();
      clearDiaryCaches();
    });
  }
}

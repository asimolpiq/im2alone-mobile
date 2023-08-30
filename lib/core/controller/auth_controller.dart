import 'package:get/get.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';

import '../../model/auth/user_model.dart';

class AuthController extends GetxController with CachingManager {
  RxBool isLogin = false.obs;
  Rx<User> currentUser = User().obs;

  logout() {
    isLogin.value = false;
    currentUser.value = User();
    removeToken();
  }
}

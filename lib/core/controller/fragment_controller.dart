import 'package:get/get.dart';
import 'package:im2alone/product/enums/project_enums.dart';

class FragmentController extends GetxController {
  Rx<MainStates> state = MainStates.feeds.obs;
  Rx<AuthStates> authState = AuthStates.myAccount.obs;
}

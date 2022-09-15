import 'package:get/get.dart';
import 'package:noonpool_web/helpers/shared_preference_util.dart';

class AppBarController extends GetxController {
  final RxInt _currentItem = 0.obs;
  final RxBool _loginStatus = AppPreferences.loginStatus.obs;
  updateCurrentItem(int id) {
    _currentItem.value = id;
  }

  bool isItemSelected(int id) => _currentItem.value == id;

  updateLoginStatus(bool isLoggedIn) {
    _loginStatus.value = isLoggedIn;
  }

  bool get isUserLoggedIn => _loginStatus.value;
}

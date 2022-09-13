import 'package:get/get.dart';

class AppBarController extends GetxController {
  final RxInt _currentItem = 0.obs;
  updateCurrentItem(int id) {
    _currentItem.value = id;
  }

  bool isItemSelected(int id) => _currentItem.value == id;
}

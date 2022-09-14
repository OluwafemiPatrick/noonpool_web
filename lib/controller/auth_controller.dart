import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxInt _currentPage = 0.obs;

  AuthController(int page) {
    updateCurrentPage(page);
  }
  updateCurrentPage(int page) {
    _currentPage.value = page;
  }

  int get currentPage => _currentPage.value;
}

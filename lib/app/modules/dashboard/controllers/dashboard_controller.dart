import 'package:get/get.dart';

class DashboardController extends GetxController {
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    update();
  }
}

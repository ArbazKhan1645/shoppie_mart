import 'package:get/get.dart';

import '../controllers/categories_home_controller.dart';

class CategoriesHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesHomeController>(
      () => CategoriesHomeController(),
    );
  }
}

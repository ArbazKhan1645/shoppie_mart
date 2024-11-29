import 'package:get/get.dart';

import '../controllers/products_home_controller.dart';

class ProductsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsHomeController>(
      () => ProductsHomeController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/favourites_home_controller.dart';

class FavouritesHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouritesHomeController>(
      () => FavouritesHomeController(),
    );
  }
}

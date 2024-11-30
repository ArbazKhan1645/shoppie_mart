import 'package:get/get.dart';
import 'package:shoppie_mart/app/get_services/splash_service/splash_service.dart';
import 'package:shoppie_mart/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    int remainingDuration = SplashService.getRemainingDuration(5000);
    Future.delayed(Duration(milliseconds: remainingDuration), () {
      Get.offNamed(Routes.DASHBOARD);
    });
  }
}

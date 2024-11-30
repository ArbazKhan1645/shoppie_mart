import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppie_mart/app/get_services/app_services/app_service.dart';
import 'package:shoppie_mart/app/get_services/fav_product_service/fav_pro_service.dart';
import 'package:shoppie_mart/app/get_services/splash_service/splash_service.dart';

Future<void> initDependencies() async {
  await _initAppService();
}

Future<void> _initAppService() async {
  await GetStorage.init();
  await Get.putAsync(() => AppService().init());
  await Get.putAsync(() => SplashService().init());
  await Get.putAsync(() => FavoriteService().init());
}

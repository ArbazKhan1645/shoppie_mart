// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../modules/categories_home/bindings/categories_home_binding.dart';
import '../modules/categories_home/views/categories_home_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/favourites_home/bindings/favourites_home_binding.dart';
import '../modules/favourites_home/views/favourites_home_view.dart';
import '../modules/products_home/bindings/products_home_binding.dart';
import '../modules/products_home/views/products_home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS_HOME,
      page: () => const ProductsHomeView(),
      binding: ProductsHomeBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES_HOME,
      page: () => const CategoriesHomeView(),
      binding: CategoriesHomeBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITES_HOME,
      page: () => const FavouritesHomeView(),
      binding: FavouritesHomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}

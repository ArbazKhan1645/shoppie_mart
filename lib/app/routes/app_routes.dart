// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const PRODUCTS_HOME = _Paths.PRODUCTS_HOME;
  static const CATEGORIES_HOME = _Paths.CATEGORIES_HOME;
  static const FAVOURITES_HOME = _Paths.FAVOURITES_HOME;
  static const PROFILE = _Paths.PROFILE;
  static const DASHBOARD = _Paths.DASHBOARD;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH_SCREEN = '/splash-screen';
  static const PRODUCTS_HOME = '/products-home';
  static const CATEGORIES_HOME = '/categories-home';
  static const FAVOURITES_HOME = '/favourites-home';
  static const PROFILE = '/profile';
  static const DASHBOARD = '/dashboard';
}

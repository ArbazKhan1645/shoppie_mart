import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppie_mart/app/modules/categories_home/views/categories_home_view.dart';
import 'package:shoppie_mart/app/modules/favourites_home/views/favourites_home_view.dart';
import 'package:shoppie_mart/app/modules/products_home/views/products_home_view.dart';
import 'package:shoppie_mart/app/modules/profile/views/profile_view.dart';

class DashboardController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  void setIndex(int index) {
    _currentIndex.value = index;
    update();
  }

  List<Widget> screens = [
    const ProductsHomeView(),
    const CategoriesHomeView(),
    const FavouritesHomeView(),
    const ProfileView()
  ];
}

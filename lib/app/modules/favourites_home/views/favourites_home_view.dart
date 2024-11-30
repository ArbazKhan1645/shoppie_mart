import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoppie_mart/app/modules/favourites_home/widgets/fav_body.dart';

import '../controllers/favourites_home_controller.dart';

class FavouritesHomeView extends GetView<FavouritesHomeController> {
  const FavouritesHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return const FavouritesProductsHomeView();
  }
}

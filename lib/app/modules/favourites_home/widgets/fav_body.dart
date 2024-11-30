// lib/screens/favorite_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppie_mart/app/commons/common_textfield.dart';
import 'package:shoppie_mart/app/modules/favourites_home/widgets/fav_prod_card.dart';
import 'package:shoppie_mart/app/modules/favourites_home/controllers/favourites_home_controller.dart';

class FavouritesProductsHomeView extends GetView<FavouritesHomeController> {
  const FavouritesProductsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesHomeController>(
        init: FavouritesHomeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  _buildTitle(context),
                  _buildSearchField(context),
                  const SizedBox(height: 10),
                  Expanded(child: _buildProductList(context))
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'Favourites',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: CommonSearchField(
        hintText: 'Search Products',
        prefixIcon: Icons.search,
        borderWidth: 1,
        onChanged: (value) => controller.searchByTitle(value),
        borderRadius: BorderRadius.circular(5),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Obx(() {
      if (controller.favorites.isEmpty) {
        return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
                child: Text('No favourite Product Added',
                    textAlign: TextAlign.center)));
      }
      if (controller.filterFavorites.isEmpty) {
        return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
                child: Text('No Search keywords found',
                    textAlign: TextAlign.center)));
      }
      return ListView.separated(
        padding: const EdgeInsets.all(5.0),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: controller.filterFavorites.length,
        itemBuilder: (context, index) {
          final product = controller.filterFavorites[index];
          return FavouriteProductCard(product: product, controller: controller);
        },
      );
    });
  }
}

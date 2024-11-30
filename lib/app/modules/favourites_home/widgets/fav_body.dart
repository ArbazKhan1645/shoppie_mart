// lib/screens/favorite_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppie_mart/app/modules/favourites_home/controllers/favourites_home_controller.dart';

class FavoriteScreen extends GetView<FavouritesHomeController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              // Clear all favorites
              controller.favoriteService.clearFavorites();
              controller.loadFavorites();
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(
            child: Text(
              'No Favorite Products',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final product = controller.favorites[index];
            return ListTile(
              title: Text(product.title ?? 'Unnamed Product'),
              subtitle: Text('\$${product.price ?? 0}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Remove from favorites
                  controller.favoriteService.removeFromFavorites(product.id!);
                  controller.loadFavorites();
                },
              ),
              leading: product.thumbnail != null
                  ? Image.network(
                      product.thumbnail!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : null,
            );
          },
        );
      }),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shoppie_mart/app/get_services/fav_product_service/fav_pro_service.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class FavoriteButton extends StatelessWidget {
  final Product product;
  final Function() onupdate;
  const FavoriteButton(
      {super.key, required this.product, required this.onupdate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FavoriteService.to.isFavorite(product.id ?? -1)) {
          FavoriteService.to.removeFromFavorites(product.id ?? -1);
        } else {
          FavoriteService.to.addToFavorites(product);
        }
        onupdate();
      },
      child: Icon(
        FavoriteService.to.isFavorite(product.id ?? -1)
            ? Icons.favorite
            : Icons.favorite_border,
        color: FavoriteService.to.isFavorite(product.id ?? -1)
            ? Colors.red
            : Colors.grey,
        size: 28.0,
      ),
    );
  }
}

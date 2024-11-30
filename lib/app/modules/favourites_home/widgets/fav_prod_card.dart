import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/commons/fav_button_widget.dart';
import 'package:shoppie_mart/app/core/managers/cache_images.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';
import 'package:shoppie_mart/app/modules/common_modules_widgets/details.dart';
import 'package:shoppie_mart/app/modules/favourites_home/controllers/favourites_home_controller.dart';

class FavouriteProductCard extends StatelessWidget {
  const FavouriteProductCard(
      {super.key, required this.product, required this.controller});

  final Product product;
  final FavouritesHomeController controller;
  static const double _imageSize = 100.0;
  static const double _padding = 12.0;
  static const double _borderRadius = 12.0;
  static const double _textFontSize = 14.0;
  static const double _priceFontSize = 14.0;
  static const double _ratingFontSize = 10.0;
  static const double _shimmerHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: InkWell(
        onTap: () => _onProductTap(),
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              const SizedBox(width: 8),
              _buildProductDetails(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.withOpacity(0.059)),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.25),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  void _onProductTap() {
    Get.to(() => ProductDetailsScreen(product: product))!.then((v) {
      controller.loadFavorites();
    });
  }

  Widget _buildProductImage() {
    return Hero(
      tag: product.title.toString(),
      child: Container(
        width: _imageSize,
        height: _imageSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: product.thumbnail != null
            ? CachedNetworkImage(
                cacheManager: PersistentCacheManager(),
                imageUrl: product.thumbnail.toString(),
                placeholder: (context, url) => _buildShimmer(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  color: Colors.red,
                ),
                fit: BoxFit.contain,
              )
            : const Icon(Icons.movie, color: Colors.grey),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: _shimmerHeight,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductTitle(),
          const SizedBox(height: 4),
          _buildProductPrice(),
          _buildRatingAndFavoriteButton(),
        ],
      ),
    );
  }

  Widget _buildProductTitle() {
    return Text(
      product.title.toString(),
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: _textFontSize,
      ),
    );
  }

  Widget _buildProductPrice() {
    return Text(
      '\$${product.price}',
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: _priceFontSize,
      ),
    );
  }

  Widget _buildRatingAndFavoriteButton() {
    return Row(
      children: [
        _buildRating(),
        const Spacer(),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Text(
          '4.9',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: _ratingFontSize,
          ),
        ),
        const SizedBox(width: 4),
        RatingBarIndicator(
          rating: 4.9,
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 10,
        ),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return FavoriteButton(
      product: product,
      onupdate: () {
        controller.loadFavorites();
        controller.update();
      },
    );
  }
}

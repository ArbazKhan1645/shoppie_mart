import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/core/managers/cache_images.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';
import 'package:shoppie_mart/app/modules/common_modules_widgets/details.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: _ProductCardContainer(product: product));
  }
}

class _ProductCardContainer extends StatelessWidget {
  const _ProductCardContainer({required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Container(
        decoration: BoxDecoration(
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
        ),
        child: _ProductCardContent(product: product),
      ),
    );
  }
}

class _ProductCardContent extends StatelessWidget {
  const _ProductCardContent({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(product: product),
          const SizedBox(height: 8),
          _ProductTitleAndPrice(product: product),
          const SizedBox(height: 4),
          _ProductRating(rating: product.rating ?? 4.9),
          const SizedBox(height: 4),
          _ProductDetails(product: product),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.title.toString(),
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: product.thumbnail != null
            ? CachedNetworkImage(
                cacheManager: PersistentCacheManager(),
                imageUrl: product.thumbnail.toString(),
                placeholder: (context, url) => buildShimmer(),
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
}

class _ProductTitleAndPrice extends StatelessWidget {
  const _ProductTitleAndPrice({required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.title.toString(),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          '\$${product.price}',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _ProductRating extends StatelessWidget {
  const _ProductRating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 4),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 10,
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'By ${product.brand}',
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'In ${product.category ?? 'Category'}',
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

Widget buildShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: double.infinity,
      height: 180,
      color: Colors.grey,
    ),
  );
}

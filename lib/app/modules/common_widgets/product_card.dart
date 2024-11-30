import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/core/managers/cache_images.dart';
import 'package:shoppie_mart/app/get_services/fav_product_service/fav_pro_service.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';
import 'package:shoppie_mart/app/modules/common_widgets/details.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.059)),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            // FavoriteService.to.addToFavorites(product);
            Get.to(() => ProductDetailsScreen(
                product: product,
                name: product.title.toString(),
                imageUrl: product.thumbnail.toString(),
                price: product.price ?? 0,
                brand: product.brand.toString(),
                rating: product.rating ?? 0,
                stock: product.stock ?? 0,
                description: product.description.toString()));
          },
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
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
                            placeholder: (context, url) => _buildShimmer(),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image,
                                color: Colors.red),
                            fit: BoxFit.contain,
                          )
                        : const Icon(Icons.movie, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
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
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Rating Section
                Row(
                  children: [
                    Text('4.9',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 10)),
                    const SizedBox(width: 4),
                    RatingBarIndicator(
                      rating: 4.9,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10,
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Subtitle Section
                Text(
                  'By Apple',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'In smartphones',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildShimmer() {
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

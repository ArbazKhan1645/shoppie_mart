import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppie_mart/app/commons/fav_button_widget.dart';
import 'package:shoppie_mart/app/commons/header.dart';
import 'package:shoppie_mart/app/core/managers/cache_images.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';
import 'package:shoppie_mart/app/modules/common_modules_widgets/product_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ProductDetailsBody(product: product)),
    );
  }
}

class ProductDetailsBody extends StatelessWidget {
  final Product product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleBar(
            title: 'Product Details',
            onBackPressed: () => Get.back(),
          ),
          HeroImage(product: product),
          ProductInfo(product: product),
          const SizedBox(height: 10),
          const DescriptionSection(),
          const SizedBox(height: 10),
          ProductGallery(product: product),
        ],
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  final Product product;
  const HeroImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.title.toString(),
      child: CachedNetworkImage(
          height: 209,
          width: double.infinity,
          cacheManager: PersistentCacheManager(),
          imageUrl: product.thumbnail.toString(),
          placeholder: (context, url) => buildShimmer(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image, color: Colors.red),
          fit: BoxFit.contain),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductTitleAndFavoriteButton(product: product),
          const SizedBox(height: 10),
          _buildInfoRow('Name:', product.title ?? 'N/A'),
          const SizedBox(height: 10),
          _buildInfoRow('Price:', '\$${product.price ?? 0}'),
          const SizedBox(height: 10),
          _buildInfoRow('Category:', product.category ?? 'N/A'),
          const SizedBox(height: 10),
          _buildInfoRow('Brand:', product.brand ?? 'N/A'),
          const SizedBox(height: 10),
          _buildRatingRow(rating: product.rating ?? 0),
          const SizedBox(height: 10),
          _buildInfoRow('Stock:', '${product.stock ?? 0}')
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      children: [
        Text(title,
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Text(value,
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400))
      ],
    );
  }

  Widget _buildRatingRow({required double rating}) {
    return Row(
      children: [
        Text('Rating:',
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Row(
          children: List.generate(5, (index) {
            return Icon(Icons.star,
                color: index < rating ? Colors.orange : Colors.grey, size: 18);
          }),
        ),
      ],
    );
  }
}

class ProductTitleAndFavoriteButton extends StatefulWidget {
  final Product product;

  const ProductTitleAndFavoriteButton({super.key, required this.product});

  @override
  State<ProductTitleAndFavoriteButton> createState() =>
      _ProductTitleAndFavoriteButtonState();
}

class _ProductTitleAndFavoriteButtonState
    extends State<ProductTitleAndFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Product Details',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
        FavoriteButton(
            product: widget.product,
            onupdate: () {
              setState(() {});
            }),
      ],
    );
  }
}

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description:',
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(
              'Lorem Ipsum är en utfyllnadstext från tryck- och förlagsindustrin. Lorem ipsum har varit standard ända.',
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class ProductGallery extends StatelessWidget {
  final Product product;
  const ProductGallery({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Gallery:',
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          MasonryGridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 4,
            shrinkWrap: true,
            crossAxisSpacing: 4,
            itemCount: product.images?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey.shade200,
                child: CachedNetworkImage(
                  cacheManager: PersistentCacheManager(),
                  imageUrl: product.images?[index] ?? '',
                  placeholder: (context, url) => buildShimmer(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, color: Colors.red),
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

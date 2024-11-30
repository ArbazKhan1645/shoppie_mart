import 'package:flutter/material.dart';
import 'package:shoppie_mart/app/commons/fav_button_widget.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String name;
  final double price;
  final String imageUrl;
  final String brand;
  final double rating;
  final int stock;
  final Product product;
  final String description;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.product,
    required this.price,
    required this.imageUrl,
    required this.brand,
    required this.rating,
    required this.stock,
    required this.description,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.name,
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FavoriteButton(
                  product: widget.product,
                  onupdate: () {
                    setState(() {});
                  },
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Brand: ${widget.brand}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Rating: ${widget.rating}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8),
                Text(
                  'Stock: ${widget.stock}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

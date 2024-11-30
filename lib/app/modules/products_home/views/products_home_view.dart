import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/commons/common_textfield.dart';
import 'package:shoppie_mart/app/core/theme/styles_manager.dart';
import 'package:shoppie_mart/app/modules/products_home/controllers/products_home_controller.dart';
import 'package:shoppie_mart/app/modules/common_modules_widgets/product_card.dart';

class ProductsHomeView extends GetView<ProductsHomeController> {
  const ProductsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsHomeController>(
        init: ProductsHomeController(),
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
        'Products',
        style: getSemiBoldStyle(fontSize: 24),
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
        onChanged: (value) => controller.searchProducts(value),
        borderRadius: BorderRadius.circular(5),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerLoader();
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return _buildErrorMessage(controller.errorMessage.value);
      }
      return ListView.separated(
        padding: const EdgeInsets.all(5.0),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return ProductCard(product: product);
        },
      );
    });
  }

  Widget _buildShimmerLoader() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      padding: const EdgeInsets.all(15.0),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
              width: double.infinity, height: 180, color: Colors.grey),
        );
      },
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(child: Text(message));
  }
}

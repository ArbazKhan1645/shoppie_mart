import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/commons/common_textfield.dart';
import 'package:shoppie_mart/app/commons/error_message_widget.dart';
import 'package:shoppie_mart/app/commons/header.dart';
import 'package:shoppie_mart/app/modules/categories_home/controllers/categories_home_controller.dart';
import 'package:shoppie_mart/app/modules/common_modules_widgets/product_card.dart';

class CategoriesProducts extends GetView<CategoriesHomeController> {
  const CategoriesProducts(this.slug, {super.key, this.categoryUrl = ''});
  final String categoryUrl;
  final String slug;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesHomeController>(
        init: CategoriesHomeController(),
        initState: (_) => controller.fetchProducts(categoryUrl),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  CustomTitleBar(
                      title: slug,
                      onBackPressed: () {
                        Get.back();
                      }),
                  _buildSearchField(context),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (controller.searching.value.isEmpty) {
                      return Container();
                    }
                    return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '${controller.filteredProducts.length} Results Found',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ));
                  }),
                  const SizedBox(height: 10),
                  Expanded(child: _buildProductList(context))
                ],
              ),
            ),
          );
        });
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
      if (controller.isLoadingProduct.value) {
        return _buildShimmerLoader();
      }
      if (controller.errorMessageProduct.value.isNotEmpty) {
        return ErrorMessageWidget(
          message: controller.errorMessage.value,
          onRetry: () {
            controller.fetchProducts(categoryUrl);
          },
        );
      }
      if (controller.filteredProducts.isEmpty) {
        return const Center(
          child: Text('No Keyword data found'),
        );
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
}

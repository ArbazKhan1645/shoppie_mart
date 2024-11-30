import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/commons/common_textfield.dart';
import 'package:shoppie_mart/app/core/theme/styles_manager.dart';
import 'package:shoppie_mart/app/modules/categories_home/widgets/categories_products.dart';
import '../controllers/categories_home_controller.dart';

class CategoriesHomeView extends GetView<CategoriesHomeController> {
  const CategoriesHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesHomeController>(
        init: CategoriesHomeController(),
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
        'Categories',
        style: getSemiBoldStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: CommonSearchField(
        hintText: 'Search Categories',
        prefixIcon: Icons.search,
        borderWidth: 1.2,
        onChanged: (value) => controller.searchCategory(value),
        borderRadius: BorderRadius.circular(12),
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
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          padding: const EdgeInsets.all(5.0),
          itemCount: controller.filteredCategories.length,
          itemBuilder: (context, index) {
            final product = controller.filteredCategories[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoriesProducts(
                    categoryUrl: product.url ?? '', key: UniqueKey()));
              },
              child: Container(
                child: Center(
                  child: Text(product.url ?? ''),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product.url.toString())),
                  color: index.isEven ? Colors.amber : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        ),
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

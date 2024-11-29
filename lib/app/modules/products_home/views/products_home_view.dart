import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/modules/products_home/controllers/products_home_controller.dart';
import 'package:shoppie_mart/app/modules/products_home/widgets/movies_itemcard.dart';

class ProductsHomeView extends GetView<ProductsHomeController> {
  const ProductsHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              onChanged: controller.searchProducts,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey,
                      ),
                    );
                  },
                );
              }
              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(controller.errorMessage.value),
                );
              }
              return ListView.builder(
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return ProductItemCardMain(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

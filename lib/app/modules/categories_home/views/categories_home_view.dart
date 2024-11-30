import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppie_mart/app/commons/common_textfield.dart';
import 'package:shoppie_mart/app/commons/error_message_widget.dart';
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
                  Obx(() {
                    if (controller.catSearching.value.isEmpty) {
                      return Container();
                    }
                    return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '${controller.filteredCategories.length} Results Found',
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

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'Categories',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
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
        return ErrorMessageWidget(
          message: controller.errorMessage.value,
          onRetry: () {
            controller.fetchCategories();
          },
        );
      }
      if (controller.filteredCategories.isEmpty) {
        return const Center(
          child: Text('No Keyword data found'),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
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
                      product.slug.toString(),
                      categoryUrl: product.url ?? '',
                      key: UniqueKey(),
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: index.isEven
                            ? const AssetImage('assets/images/cat2.png')
                            : const AssetImage('assets/images/cat1.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF0C0C0C).withOpacity(0.25),
                              const Color(0xFF0C0C0C).withOpacity(0.25)
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        ),
      );
    });
  }

  Widget _buildShimmerLoader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        padding: const EdgeInsets.all(5.0),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: 180),
          );
        },
      ),
    );
  }
}

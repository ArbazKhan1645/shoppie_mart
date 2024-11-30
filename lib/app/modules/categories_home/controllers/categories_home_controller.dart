import 'package:get/get.dart';
import 'package:shoppie_mart/app/api_services/categories_service/category_service.dart';
import 'package:shoppie_mart/app/api_services/product_service/product_service.dart';
import 'package:shoppie_mart/app/core/utils/api_exceptions.dart';
import 'package:shoppie_mart/app/core/utils/logger.dart';
import 'package:shoppie_mart/app/models/category_model/category_model.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class CategoriesHomeController extends GetxController {
  final CategoriesApiService _categoryApiService;
  final RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  final RxList<CategoryModel> filteredCategories = RxList<CategoryModel>([]);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = RxString('');
  final ProductsApiService _productsApiService;
  final RxList<Product> products = RxList<Product>([]);
  final RxList<Product> filteredProducts = RxList<Product>([]);
  final RxBool isLoadingProduct = true.obs;
  final RxString errorMessageProduct = RxString('');
  CategoriesHomeController(
      {CategoriesApiService? categoryApiService,
      ProductsApiService? productsApiService})
      : _productsApiService = productsApiService ?? ProductsApiService(),
        _categoryApiService = categoryApiService ?? CategoriesApiService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<CategoryModel> response =
          await _categoryApiService.fetchCategoriesFromAPi();
      categories.value = response;
      filteredCategories.value = categories;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      AppLogger.error('API error: ${e.message}');
    } catch (e) {
      errorMessage.value = 'Unexpected error occurred';
      AppLogger.error('Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  RxString catSearching = ''.obs;
  void searchCategory(String query) {
    catSearching.value = query;
    filteredCategories.value = categories
        .where((category) => category.name
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  @override
  void onClose() {
    _categoryApiService.dispose();
    _productsApiService.dispose();
    super.onClose();
  }

  RxString searching = ''.obs;
  void searchProducts(String query) {
    searching.value = query;
    filteredProducts.value = products
        .where((product) => product.title
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  Future<void> fetchProducts(String url) async {
    try {
      isLoadingProduct.value = true;
      errorMessageProduct.value = '';
      final ProductResponse response =
          await _productsApiService.fetchProductsFromAPi(url);
      products.value = response.products ?? [];
      filteredProducts.value = products;
      AppLogger.info(filteredProducts.length.toString());
    } on ApiException catch (e) {
      errorMessageProduct.value = e.message;
      AppLogger.error('API error: ${e.message}');
    } catch (e) {
      errorMessageProduct.value = 'Unexpected error occurred';
      AppLogger.error('Unexpected error: $e');
    } finally {
      isLoadingProduct.value = false;
    }
  }
}

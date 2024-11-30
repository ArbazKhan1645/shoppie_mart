import 'package:get/get.dart';
import 'package:shoppie_mart/app/api_services/product_service/product_service.dart';
import 'package:shoppie_mart/app/core/configs/api_configs.dart';
import 'package:shoppie_mart/app/core/utils/api_exceptions.dart';
import 'package:shoppie_mart/app/core/utils/logger.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class ProductsHomeController extends GetxController {
  final ProductsApiService _productsApiService;
  final RxList<Product> products = RxList<Product>([]);
  final RxList<Product> filteredProducts = RxList<Product>([]);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = RxString('');

  ProductsHomeController({ProductsApiService? productsApiService})
      : _productsApiService = productsApiService ?? ProductsApiService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final ProductResponse response = await _productsApiService
          .fetchProductsFromAPi(ApiConfig.productbaseUrl);
      products.value = response.products ?? [];
      filteredProducts.value = products;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      AppLogger.error('API error: ${e.message}');
    } catch (e) {
      errorMessage.value = 'Unexpected error occurred';
      AppLogger.error('Unexpected error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
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

  @override
  void onClose() {
    _productsApiService.dispose();
    super.onClose();
  }
}

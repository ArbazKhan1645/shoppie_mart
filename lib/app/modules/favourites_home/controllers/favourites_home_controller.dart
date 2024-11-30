import 'package:get/get.dart';
import 'package:shoppie_mart/app/get_services/fav_product_service/fav_pro_service.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class FavouritesHomeController extends GetxController {
  final favoriteService = FavoriteService.to;
  final RxList<Product> favorites = <Product>[].obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }


  void loadFavorites() {
    favorites.value = favoriteService.getFavorites();
  }


  void toggleFavorite(Product product) {
    if (favoriteService.isFavorite(product.id!)) {
      favoriteService.removeFromFavorites(product.id!);
    } else {
      favoriteService.addToFavorites(product);
    }
    loadFavorites();
  }

  // Check if a product is favorite
  bool isFavorite(int productId) {
    return favoriteService.isFavorite(productId);
  }
}

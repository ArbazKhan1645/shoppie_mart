// lib/services/favorite_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppie_mart/app/core/utils/logger.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class FavoriteService extends GetxService {
  static FavoriteService get to => Get.find();

  final _storage = GetStorage();
  final _favKey = 'favorite_products';

  Future<FavoriteService> init() async {
    getFavorites();
    return this;
  }

  Future<void> addToFavorites(Product product) async {
    try {
      List<Product> currentFavorites = getFavorites();
      if (!currentFavorites.any((p) => p.id == product.id)) {
        currentFavorites.add(product);
        await _storage.write(
            _favKey, currentFavorites.map((p) => p.toJson()).toList());
        AppLogger.info('message completed');
      }
    } catch (e) {
      AppLogger.error('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(int productId) async {
    try {
      List<Product> currentFavorites = getFavorites();
      currentFavorites.removeWhere((p) => p.id == productId);
      await _storage.write(
          _favKey, currentFavorites.map((p) => p.toJson()).toList());
    } catch (e) {
      AppLogger.error('Error removing from favorites: $e');
    }
  }

  List<Product> getFavorites() {
    try {
      final List<dynamic>? storedFavorites = _storage.read(_favKey);
      if (storedFavorites == null) return [];
      return storedFavorites.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Error getting favorites: $e');
      return [];
    }
  }

  bool isFavorite(int productId) {
    return getFavorites().any((p) => p.id == productId);
  }

  Future<void> clearFavorites() async {
    await _storage.remove(_favKey);
  }
}

extension ProductExtension on Product {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions?.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews?.map((r) => r.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta?.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

extension DimensionsExtension on Dimensions {
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}

extension ReviewExtension on Review {
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date?.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

extension MetaExtension on Meta {
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}

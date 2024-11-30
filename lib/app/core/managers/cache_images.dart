// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PersistentCacheManager extends CacheManager {
  static final _instance = PersistentCacheManager._internal();
  factory PersistentCacheManager() {
    return _instance;
  }
  PersistentCacheManager._internal()
      : super(Config('persistentImagesCache',
            stalePeriod: const Duration(days: 90), maxNrOfCacheObjects: 500));
}

Future<void> prefetchProductThumbnail(List<String> posterPaths) async {
  final cacheManager = PersistentCacheManager();
  for (String path in posterPaths) {
    final imageUrl = path;
    final fileInfo = await cacheManager.getFileFromCache(imageUrl);
    if (fileInfo == null) {
      await cacheManager.downloadFile(imageUrl);
    }
  }
}

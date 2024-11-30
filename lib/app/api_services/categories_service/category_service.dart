// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_import

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import 'package:shoppie_mart/app/core/configs/api_configs.dart';
import 'package:shoppie_mart/app/core/utils/api_exceptions.dart';
import 'package:shoppie_mart/app/core/utils/logger.dart';
import 'package:shoppie_mart/app/get_services/app_services/app_service.dart';
import 'package:shoppie_mart/app/models/category_model/category_model.dart';
import 'package:shoppie_mart/app/models/product_model/product_model.dart';

class CategoriesApiService {
  final http.Client _client;
  CategoriesApiService({http.Client? client})
      : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<CategoryModel>> fetchCategoriesFromAPi() async {
    try {
      if (!_appService.isConnected) {
        throw ApiException('No internet connection');
      }
      final response = await retry(() => _makeRequest(),
          retryIf: ApiConfig.shouldRetry,
          maxAttempts: ApiConfig.maxRetries,
          delayFactor: ApiConfig.retryDelay);
      final data = json.decode(response.body) as List<dynamic>;
      List<CategoryModel> categories = data
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      AppLogger.info(categories.length.toString());
      return categories;
    } on TimeoutException {
      throw ApiException('Request timed out');
    } on SocketException {
      throw ApiException('No internet connection');
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<http.Response> _makeRequest() async {
    Map<String, String> _headers = {'Content-Type': 'application/json'};
    final response = await _client
        .get(Uri.parse(ApiConfig.categoriesbaseUrl), headers: _headers)
        .timeout(ApiConfig.timeout);
    ApiConfig.validateResponse(response);
    return response;
  }

  final AppService _appService = Get.find<AppService>();
}

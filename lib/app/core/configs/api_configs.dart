import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shoppie_mart/app/core/utils/api_exceptions.dart';

class ApiConfig {
  static const String productbaseUrl =
      'https://dummyjson.com/products?limit=30';
  static const String categoriesbaseUrl =
      'https://dummyjson.com/products/categories';

  static const Duration timeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static bool shouldRetry(Exception e) {
    if (e is ApiException) {
      return e.statusCode != null &&
          (e.statusCode! >= 500 || e.statusCode == 429);
    }
    return e is SocketException || e is TimeoutException;
  }

  static String? getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return null;
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized - Check your API key';
      case 403:
        return 'Forbidden - You don\'t have access';
      case 404:
        return 'Not found - Check the API endpoint';
      case 429:
        return 'Rate limit exceeded';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Server error - Please try again later';
      default:
        return 'Unexpected status code: $statusCode';
    }
  }

  static void validateResponse(http.Response response) {
    final statusCode = response.statusCode;
    final errorMessage = ApiConfig.getErrorMessage(statusCode);
    if (errorMessage != null) {
      throw ApiException(
        errorMessage,
        statusCode: statusCode,
        response: response.body,
      );
    }
  }
}

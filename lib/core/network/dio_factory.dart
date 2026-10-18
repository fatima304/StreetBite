import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

/// Central place for HTTP client configuration.
class DioFactory {
  DioFactory._();

  static Dio createMealDio() => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  static Dio createStripeDio() => Dio(
    BaseOptions(
      baseUrl: ApiConstants.stripeBaseUrl,
      contentType: Headers.formUrlEncodedContentType,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
}

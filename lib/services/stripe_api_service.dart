import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../core/constants/api_constants.dart';
import '../data/models/payment_intent_model.dart';

part 'stripe_api_service.g.dart';

/// Stripe HTTP endpoints, TEST MODE ONLY.
@RestApi(baseUrl: ApiConstants.stripeBaseUrl)
abstract class StripeApiService {
  factory StripeApiService(Dio dio, {String? baseUrl}) = _StripeApiService;

  @POST('payment_intents')
  Future<PaymentIntentModel> createPaymentIntent(
    @Body() Map<String, dynamic> data,
    @Header('Authorization') String authorization,
  );

  @GET('payment_intents/{intentId}')
  Future<PaymentIntentModel> getPaymentIntent(
    @Path('intentId') String intentId,
    @Header('Authorization') String authorization,
  );
}

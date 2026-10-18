import 'package:flutter_stripe/flutter_stripe.dart';

import '../data/models/payment_intent_input_model.dart';
import '../data/models/payment_intent_model.dart';
import '../domain/entities/payment_receipt.dart';
import 'stripe_api_service.dart';

/// TEST MODE ONLY. A secret key in a client APK is extractable.
/// Use a trusted backend for PaymentIntents before any real deployment.
class StripePaymentService {
  StripePaymentService({required this.secretKey, required this.api});

  final String secretKey;
  final StripeApiService api;

  String get _authorization {
    if (!secretKey.startsWith('sk_test_')) {
      throw StateError('Only a Stripe test secret key is allowed.');
    }
    return 'Bearer $secretKey';
  }

  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel input,
  }) async {
    final data = <String, dynamic>{
      ...input.toJson().map((key, value) => MapEntry(key, value.toString())),
      'automatic_payment_methods[enabled]': 'true',
    };
    final intent = await api.createPaymentIntent(data, _authorization);
    if (intent.id.isEmpty || intent.clientSecret.isEmpty) {
      throw StateError('Invalid Stripe PaymentIntent response.');
    }
    return intent;
  }

  Future<void> presentPaymentSheet({required String clientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'StreetBite',
        paymentIntentClientSecret: clientSecret,
      ),
    );
    await Stripe.instance.presentPaymentSheet();
  }

  Future<String> getPaymentStatus(String intentId) async {
    final data = await api.getPaymentIntent(intentId, _authorization);
    return data.status;
  }

  Future<PaymentReceipt> pay({required PaymentIntentInputModel input}) async {
    final intent = await createPaymentIntent(input: input);
    await presentPaymentSheet(clientSecret: intent.clientSecret);
    final status = await getPaymentStatus(intent.id);
    if (status != 'succeeded') {
      throw StateError('Payment not confirmed (status: $status).');
    }
    return PaymentReceipt(paymentIntentId: intent.id, status: status);
  }
}

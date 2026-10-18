import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_input_model.g.dart';

@JsonSerializable(createFactory: false)
class PaymentIntentInputModel {
  const PaymentIntentInputModel({required this.amount, this.currency = 'usd'});

  /// Amount in the smallest currency unit (cents for USD).
  final int amount;

  final String currency;

  Map<String, dynamic> toJson() => _$PaymentIntentInputModelToJson(this);
}

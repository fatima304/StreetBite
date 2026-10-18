import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
  const OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.status,
    this.paymentStatus = '',
    this.paymentIntentId,
    this.userId = '',
    this.subtotal = 0,
    this.deliveryFee = 0,
    this.createdAt,
  });

  @JsonKey(includeToJson: false, defaultValue: '')
  final String id;

  @JsonKey(defaultValue: '')
  final String userId;

  final List<Map<String, dynamic>> items;

  @JsonKey(fromJson: _toDouble, defaultValue: 0.0)
  final double subtotal;

  @JsonKey(fromJson: _toDouble, defaultValue: 0.0)
  final double deliveryFee;

  @JsonKey(fromJson: _toDouble, defaultValue: 0.0)
  final double total;

  @JsonKey(defaultValue: 'cash')
  final String paymentMethod;

  @JsonKey(defaultValue: 'pending')
  final String status;

  @JsonKey(defaultValue: '')
  final String paymentStatus;

  final String? paymentIntentId;

  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime? createdAt;

  static double _toDouble(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _dateFromJson(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static String? _dateToJson(DateTime? date) {
    return date?.toIso8601String();
  }

  factory OrderModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return _$OrderModelFromJson({...json, 'id': id ?? json['id'] ?? ''});
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  factory OrderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return OrderModel.fromJson(doc.data() ?? <String, dynamic>{}, id: doc.id);
  }
}

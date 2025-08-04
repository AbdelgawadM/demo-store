import 'package:our_store/core/models/product_model.dart';

class DiscountModel {
  final String id;
  final String forProductId;
  final ProductModel product;

  DiscountModel({
    required this.id,
    required this.forProductId,
    required this.product,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'],
      forProductId: json['for_product'],
      product: ProductModel.fromJson(json['products']),
    );
  }
}

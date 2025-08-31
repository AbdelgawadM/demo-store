import 'package:our_store/views/products/logic/models/product_view_model.dart';

class FavoriteModel {
  final String? favId; // This is the favorite_favId
  final ProductViewModel productViewModel;

  FavoriteModel({this.favId, required this.productViewModel});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favId: json['favorite_id'],
      productViewModel: ProductViewModel.fromJson(json['products']),
    );
  }
  static Map<String, dynamic> toJson({
    required String userId,
    required String productId,
  }) {
    return {'for_product': productId, 'for_user': userId};
  }
}

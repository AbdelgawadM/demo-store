import 'package:our_store/core/models/product_view_model.dart';

class FavoriteModel {
  final String favId; // This is the favorite_favId
  final ProductViewModel productViewModel;

  FavoriteModel({required this.favId, required this.productViewModel});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favId: json['favorite_id'],
      productViewModel: ProductViewModel.fromJson(json),
    );
  }
}

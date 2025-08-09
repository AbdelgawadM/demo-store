import 'package:meta/meta.dart';
import 'package:our_store/core/models/product_details_model.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final List<ProductDetailsModel> productDetailsModel;

  ProductDetailsSuccess({required this.productDetailsModel});
}

final class ProductDetailsFaluire extends ProductDetailsState {
  final String message;

  ProductDetailsFaluire({required this.message});
}

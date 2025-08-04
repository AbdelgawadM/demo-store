import 'package:meta/meta.dart';
import 'package:our_store/core/models/product_model.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductSuccess extends ProductsState {
  final List<ProductModel> productModel;

  ProductSuccess({required this.productModel});
}

final class ProductLoading extends ProductsState {}

final class ProductFaluire extends ProductsState {
  final String message;

  ProductFaluire({required this.message});
}

final class DiscountLoading extends ProductsState {}

final class DiscountSuccess extends ProductsState {
  final List<DiscountModel> discountModel;

  DiscountSuccess({required this.discountModel});
}

final class DiscountFaluire extends ProductsState {
  final String message;

  DiscountFaluire({required this.message});
}

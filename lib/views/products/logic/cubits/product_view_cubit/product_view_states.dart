import 'package:meta/meta.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';

@immutable
sealed class ProductViewState {}

final class ProductViewInitial extends ProductViewState {}

final class ProductViewLoading extends ProductViewState {}

final class ProductViewSuccess extends ProductViewState {
  final List<ProductViewModel> productViewModel;

  ProductViewSuccess({required this.productViewModel});
}

final class ProductViewFaluire extends ProductViewState {
  final String message;

  ProductViewFaluire({required this.message});
}



import 'package:meta/meta.dart';
import 'package:our_store/views/products/logic/models/product_view_model.dart';

@immutable
sealed class BestsellerViewState {}

final class BestSellerInitial extends BestsellerViewState {}

final class BestSellerViewLoading extends BestsellerViewState {}

final class BestSellerViewSuccess extends BestsellerViewState {
  final List<ProductViewModel> productViewModel;

  BestSellerViewSuccess({required this.productViewModel});
}

final class BestSellerViewFaluire extends BestsellerViewState {
  final String message;

  BestSellerViewFaluire({required this.message});
}

import 'package:meta/meta.dart';
import 'package:our_store/core/models/details_model.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class ProductDetailsLoading extends DetailsState {}

final class ProductDetailsSuccess extends DetailsState {
  final List<DetailsModel> productDetailsModel;

  ProductDetailsSuccess({required this.productDetailsModel});
}

final class ProductDetailsFaluire extends DetailsState {
  final String message;

  ProductDetailsFaluire({required this.message});
}

final class DiscountDetailsInitial extends DetailsState {}

final class DiscountDetailsLoading extends DetailsState {}

final class DiscountDetailsSuccess extends DetailsState {
  final List<DetailsModel> discountDetailsModel;

  DiscountDetailsSuccess({required this.discountDetailsModel});
}

final class DiscountDetailsFaluire extends DetailsState {
  final String message;

  DiscountDetailsFaluire({required this.message});
}

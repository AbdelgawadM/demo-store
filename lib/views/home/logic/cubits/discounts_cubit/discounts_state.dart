import 'package:meta/meta.dart';
import 'package:our_store/views/home/logic/models/discounts_model.dart';

@immutable
sealed class DiscountsState {}

final class DiscountsInitial extends DiscountsState {}

final class DiscountLoading extends DiscountsState {}

final class DiscountSuccess extends DiscountsState {
  final List<DiscountModel> discountModel;

  DiscountSuccess({required this.discountModel});
}

final class DiscountFaluire extends DiscountsState {
  final String message;

  DiscountFaluire({required this.message});
}

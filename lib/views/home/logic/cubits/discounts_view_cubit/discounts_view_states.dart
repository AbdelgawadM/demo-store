import 'package:meta/meta.dart';
import 'package:our_store/views/home/logic/models/discounts_view_model.dart';

@immutable
sealed class DiscountsViewState {}

final class DiscountsViewInitial extends DiscountsViewState {}

final class DiscountsViewLoading extends DiscountsViewState {}

final class DiscountsViewSuccess extends DiscountsViewState {
  final List<DiscountsViewModel> discountViewModel;

  DiscountsViewSuccess({required this.discountViewModel});
}

final class DiscountsViewFaluire extends DiscountsViewState {
  final String message;

  DiscountsViewFaluire({required this.message});
}

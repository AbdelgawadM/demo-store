import 'package:meta/meta.dart';
import 'package:our_store/views/home/logic/models/discounts_details_model.dart';

@immutable
sealed class DiscountsDetailsState {}

final class DiscountsDetailsInitial extends DiscountsDetailsState {}

final class DiscountsDetailsLoading extends DiscountsDetailsState {}

final class DiscountsDetailsSuccess extends DiscountsDetailsState {
  final List<DiscountsDetailsModel> discountDetailsModel;

  DiscountsDetailsSuccess({required this.discountDetailsModel});
}

final class DiscountsDetailsFaluire extends DiscountsDetailsState {
  final String message;

  DiscountsDetailsFaluire({required this.message});
}

import 'package:our_store/core/models/product_view_model.dart';

class DiscountsViewModel {
  final String discountId;
  final int discount;
  final ProductViewModel productViewModel;
  // final double oldPrice;

  DiscountsViewModel({
    required this.discount,
    required this.productViewModel,
    required this.discountId,
    // required this.oldPrice,
  });

  factory DiscountsViewModel.fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic> lastJson =
    //     json['products'] ;

    return DiscountsViewModel(
      discountId: json['discount_id'],
      discount: json['discount'],
      productViewModel: ProductViewModel.fromJson(json),
      // oldPrice: (json['old_price'] as num).toDouble(),
    );
  }
}

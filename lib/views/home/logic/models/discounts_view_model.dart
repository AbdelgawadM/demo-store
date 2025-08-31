import 'package:our_store/views/products/logic/models/product_view_model.dart';

class DiscountsViewModel {
  final String discountId;
  final int discount;
  final double newPrice;
  final ProductViewModel productViewModel;

  DiscountsViewModel({
    required this.discount,
    required this.productViewModel,
    required this.discountId,
    required this.newPrice,
  });

  factory DiscountsViewModel.fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic> lastJson =
    //     json['products'] ;

    return DiscountsViewModel(
      discountId: json['discount_id'],
      discount: json['discount'],
      productViewModel: ProductViewModel.fromJson(json['products']),
      newPrice: (json['new_price'] as num).toDouble(),
    );
  }
}

class DiscountsViewModel {
  final String id;
  final String name;
  final double price;
  // final double oldPrice;
  final int discount;
  final String imageUrl;
  final double avgRate;
  DiscountsViewModel({
    required this.id,
    required this.name,
    required this.price,
    // required this.oldPrice,
    required this.discount,
    required this.imageUrl,
    required this.avgRate,
  });

  factory DiscountsViewModel.fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic> lastJson =
    //     json['products'] ;

    return DiscountsViewModel(
      id: json['for_product'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      // oldPrice: (json['old_price'] as num).toDouble(),
      discount: (json['discount']),
      imageUrl: json['image_url'],
      avgRate: (json['avg_rating'] as num?)?.toDouble() ?? 0,
    );
  }
}

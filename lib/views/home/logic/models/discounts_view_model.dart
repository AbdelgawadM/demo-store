class DiscountsViewModel {
  final String id;
  final String name;
  final double price;
  final double oldPrice;
  final int discount;
  final String imageUrl;

  DiscountsViewModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
  });

  factory DiscountsViewModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> lastJson =
        json['products'] ;

    return DiscountsViewModel(
      id: lastJson['id'],
      name: lastJson['name'],
      price: (lastJson['price'] as num).toDouble(),
      oldPrice: (lastJson['old_price'] as num).toDouble(),
      discount: (lastJson['discount']),
      imageUrl: lastJson['image_url'],
    );
  }
}

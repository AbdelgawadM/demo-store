class ProductViewModel {
  final String id;
  final String name;
  final double price;
  final double oldPrice;
  final String imageUrl;

  ProductViewModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
  });

  factory ProductViewModel.fromJson(Map<String, dynamic> json) {
    return ProductViewModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      oldPrice: (json['old_price'] as num).toDouble(),
      imageUrl: json['image_url'],
    );
  }
}

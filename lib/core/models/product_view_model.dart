class ProductViewModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double avgRate;

  ProductViewModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.avgRate,
  });

  factory ProductViewModel.fromJson(Map<String, dynamic> json) {
    return ProductViewModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
      avgRate: (json['avg_rating'] as num?)?.toDouble() ?? 0,
    );
  }
}

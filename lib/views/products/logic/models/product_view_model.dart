
class ProductViewModel {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final double avgRate;
  bool? isFav;

  ProductViewModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.avgRate,
    this.isFav,
  });

  factory ProductViewModel.fromJson(Map<String, dynamic> json) {
    return ProductViewModel(
      productId: json['product_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
      avgRate:
          (json['product_avg_rates'] != null &&
              (json['product_avg_rates'] as List).isNotEmpty)
          ? (json['product_avg_rates'][0]['avg_rate'] as num?)?.toDouble() ?? 0
          : 0,
      isFav: (json['favorites'] == null)
          ? true
          : (json['favorites'] as List).isEmpty
          ? false
          : true,
    );
  }
}

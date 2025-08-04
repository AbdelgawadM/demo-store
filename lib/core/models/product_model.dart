class ProductModel {
  final String name;
  final double price;
  final double oldPrice;
  final int discount;
  final String description;
  final String category;
  final String imageUrl;

  ProductModel( {
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.description,
    required this.category,
    required this.imageUrl
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 5.5,
      oldPrice: (json['old_price'] as num?)?.toDouble() ?? 5.5,
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image_url']
    );
  }
}

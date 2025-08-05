class ProductModel {
  final String id;
  final String? name;
  final double? price;
  final double? oldPrice;
  final int? discount;
  final String? description;
  final String? category;
  final String? imageUrl;

  ProductModel({
    required this.id,
    this.name,
    this.price,
    this.oldPrice,
    this.discount,
    this.description,
    this.category,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']??'55',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 5.5,
      oldPrice: (json['old_price'] as num?)?.toDouble() ?? 5.5,
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image_url']??'https://www.zdnet.com/a/img/resize/263c8a0e641d17d5b6efceb974c339efc290fae8/2023/07/13/418f0a70-0ca4-4679-b02b-1ed60a12dfab/iphone-ios-17.jpg?auto=webp&width=1280',
    );
  }
}

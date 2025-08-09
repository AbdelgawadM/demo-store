class ProductDetailsModel {
  final String description;

  ProductDetailsModel({required this.description});
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(description: json['description']);
  }
}

class CategoryModel {
  final String categoryId;
  final String label;
  final String imageUrl;

  CategoryModel({
    required this.label,
    required this.imageUrl,
    required this.categoryId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'],
      label: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

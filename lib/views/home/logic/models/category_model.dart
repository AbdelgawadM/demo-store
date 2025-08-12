class CategoryModel {
  final String id;
  final String label;
  final String imageUrl;

  CategoryModel({
    required this.label,
    required this.imageUrl,
    required this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      label: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

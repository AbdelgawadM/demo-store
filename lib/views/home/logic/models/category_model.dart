class CategoryModel {
  final String label;

  CategoryModel({required this.label});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      label: json['category'] as String? ?? 'Unknown Category',
    );
  }
}

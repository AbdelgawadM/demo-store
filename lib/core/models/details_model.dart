class DetailsModel {
  final String description;
  final double rate;

  DetailsModel({required this.description, required this.rate});
  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      description: json['description'],
      rate:
          (json['product_avg_rates'] != null &&
              (json['product_avg_rates'] as List).isNotEmpty)
          ? (json['product_avg_rates'][0]['rate'] as num?)?.toDouble() ?? 0
          : 0,
    );
  }
}

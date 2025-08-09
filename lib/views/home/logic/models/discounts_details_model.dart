class DiscountsDetailsModel {
  final String description;

  DiscountsDetailsModel({required this.description});
  factory DiscountsDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final Map<String, dynamic> lastJson =
        json['products'] as Map<String, dynamic>;
    return DiscountsDetailsModel(description: lastJson['description']);
  }
}

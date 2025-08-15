class DetailsModel {
  final String description;

  DetailsModel({required this.description});
  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(description: json['description']);
  }
}

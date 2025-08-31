class UserModel {
  final String userId;
  final String name;
  final String email;

  UserModel({required this.userId, required this.name, required this.email});

  // Factory constructor to create an instance from Supabase JSON
  factory UserModel.fromJson(List<Map<String, dynamic>> response) {
    Map<String, dynamic> json = response.first;
    return UserModel(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  // // Optional: Convert model back to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'email': email,
  //   };
  // }
}

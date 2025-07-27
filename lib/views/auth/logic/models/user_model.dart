class UserModel {
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
  });

  // Factory constructor to create an instance from Supabase JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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



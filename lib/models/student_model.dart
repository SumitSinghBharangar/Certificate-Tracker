class UserModel {
  final String stName;
  final String email;
  final String id;
  final int phone;

  UserModel({
    required this.stName,
    required this.email,
    required this.id,
    required this.phone,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      stName: data['name'],
      email: data['email'],
      id: data["id"],
      phone: data["Phone"] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': stName,
      'email': email,
      "id": id,
      "phone": phone,
    };
  }
}

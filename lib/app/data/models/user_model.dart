class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id_user'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profile_image'] ?? '',
    );
  }
}
class User {
  String userId;
  String name;
  String username;
  String email;
  String password;
  String role;

  User({
    required this.userId,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] ?? 'No ID',
      name: json['name'] ?? 'Unknown',
      username: json['username'] ?? 'Unknown',
      email: json['email'] ?? 'unknown',
      password: json['password'] ?? 'Unknown',
      role: json['role'] ?? 'Unknown',
    );
  }
}

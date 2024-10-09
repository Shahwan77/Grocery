class User {
  final String? name;
  final String? mobileNo;
  final String? email;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? accessToken; // Add this line

  User({
    this.name,
    this.mobileNo,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.accessToken, // Add this line
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name']??'',
      mobileNo: json['mobile_no']??'',
      email: json['email']??'',
      updatedAt: json['updated_at']??'',
      createdAt: json['created_at']??'',
      id: json['id']??0,
      accessToken: json['access_token']??'', // Add this line
    );
  }
}
class RegisterResponse {
  final bool success;  // Add success field
  final String message;
  final User user;

  RegisterResponse({
    required this.success, // Add success field
    required this.message,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'], // Parse success field
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

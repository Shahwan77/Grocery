class Staff {
  final String id;
  final String name;
  final String mobileNo;

  Staff({
    required this.id,
    required this.name,
    required this.mobileNo,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'].toString(),
      name: json['name'],
      mobileNo: json['mobile_no'] ?? '', // Use a default value if null
    );
  }
}

class User {
  final String id;
  final String name;
  final String mobileNo;

  User({
    required this.id,
    required this.name,
    required this.mobileNo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      mobileNo: json['mobile_no'] ?? '', // Use a default value if null
    );
  }
}

class InProgressModel {
  final String id;
  final String orderId;
  final String status;
  final Staff staff;
  final User user;

  InProgressModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.staff,
    required this.user,
  });

  factory InProgressModel.fromJson(Map<String, dynamic> json) {
    return InProgressModel(
      id: json['id'].toString(),
      orderId: json['order_id'],
      status: json['status'],
      staff: Staff.fromJson(json['staff']),
      user: User.fromJson(json['user']),
    );
  }
}

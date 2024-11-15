class Shop {
  final String id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String? image;
  final String createdAt;
  final String updatedAt;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

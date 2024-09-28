import 'package:get/get.dart';

class Models {
  final int id;
  final String name;
  final String image;
  final String price;
  final int categoryId;
  final int? subcategoryId; // Nullable
  final String? description; // Nullable
  final int status;
  final String createdAt;
  final String updatedAt;
  final int popular;
  final int discount;
  final bool isSubCategories;
  final dynamic cart;
  final List<Models>? subCategories; // Add this line for subcategories


  Models({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.categoryId,
    this.subcategoryId,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.popular,
    required this.discount,
    required this.isSubCategories,
    this.cart,
    this.subCategories, // Add this line

  });

  factory Models.fromJson(Map<String, dynamic> json) {
    return Models(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      price: json['price'] ?? '0.0',
      categoryId: json['category_id'] ?? 0,
      subcategoryId: json['subcategory_id'], // Nullable
      description: json['description'], // Nullable
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      popular: json['popular'] ?? 0,
      discount: json['discount'] ?? 0,
      isSubCategories: json['is_sub_categories'] ?? false,
      cart: json['cart'],
      subCategories: (json['sub_categories'] as List?)?.map((item) => Models.fromJson(item)).toList(), // Deserialize subcategories

    );
  }
}

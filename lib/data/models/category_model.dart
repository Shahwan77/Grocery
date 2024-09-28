class Category {
  final int id;
  final String name; // Make name nullable
  final String? description; // Nullable field
  final String? image; // Make image nullable
  final int? status;
  final bool? popular;
  final bool isSubCategories;
  final List<dynamic> subCategory;

  Category({
    required this.id,
    required this.name, // Make name optional
    this.description,
    this.image, // Make image optional
    this.status,
    this.popular,
    required this.isSubCategories,
    required this.subCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'] ?? 'Unknown', // Provide default if name is null
      description: json['description'], // Handle nulls with nullable type
      image: json['image'] ?? 'default_image.png', // Provide default if image is null
      status: json['status'],
      popular: json['popular'] == 1, // Convert integer to bool
      isSubCategories: json['is_sub_categories'] == true,
      subCategory: List<dynamic>.from(json['sub_category'] ?? []), // Handle null subCategory
    );
  }
}

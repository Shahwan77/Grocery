class MostCategory {
  final int id;
  final String name;
  final String type;
  final String? description;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int popular;
  final bool isSubCategories;
  final List<dynamic> subCategory;

  MostCategory({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.popular,
    required this.isSubCategories,
    required this.subCategory,
  });

  factory MostCategory.fromJson(Map<String, dynamic> json) {
    return MostCategory(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      popular: json['popular'],
      isSubCategories: json['is_sub_categories'],
      subCategory: json['sub_category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'popular': popular,
      'is_sub_categories': isSubCategories,
      'sub_category': subCategory,
    };
  }
}

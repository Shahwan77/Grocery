import 'package:get/get.dart';

class Models {
  final int id;
  final int shopId;
  final int productId;
  final String price;
  final String type;
  final int popular;
  final int discount;
  final String discountType;
  final String discountValue;
  final String createdAt;
  final String updatedAt;
  final double? promotionPrice;
  final ProductModel product;
  final List<ServiceModel> services;


  Models({
    required this.id,
    required this.shopId,
    required this.productId,
    required this.price,
    required this.type,
    required this.popular,
    required this.discount,
    required this.discountType,
    required this.discountValue,
    required this.createdAt,
    required this.updatedAt,
    required this.promotionPrice,
    required this.product,
    required this.services,
  });

  factory Models.fromJson(Map<String, dynamic> json) {
    return Models(
      id: json['id'] ?? 0,
      shopId: json['shop_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      price: json['price'] ?? '0.0',
      type: json['type'] ?? '',
      popular: json['popular'] ?? 0,
      discount: json['discount'] ?? 0,
      discountType: json['discount_type'] ?? '',
      discountValue: json['discount_value'] ?? '0',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      promotionPrice: json['promotion_price'] != null && json['promotion_price'] != ''
          ? double.tryParse(json['promotion_price'].toString())
          : null,
      services: json['services'] != null
          ? (json['services'] as List).map((service) => ServiceModel.fromJson(service)).toList()
          : [],

      product: ProductModel.fromJson(json['product']), // Updated to use ProductModel
    );
  }
}

class ProductModel {
  final int id;
  final String type;
  final String name;
  final int categoryId;
  final int? subcategoryId;
  final String? description;
  final String image;
  final String price;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int popular;
  final int discount;
  final CategoryModel category;


  ProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.categoryId,
    this.subcategoryId,
    this.description,
    required this.image,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.popular,
    required this.discount,
    required this.category,

  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Check if the required fields are null before accessing them
    final categoryData = json['category'];
    final servicesData = json['services'];

    return ProductModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      name: json['name'] ?? 'Unknown',
      categoryId: json['category_id'] ?? 0,
      subcategoryId: json['subcategory_id'],
      description: json['description'],
      image: json['image'] ?? '',
      price: json['price'] ?? '0.0',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      popular: json['popular'] ?? 0,
      discount: json['discount'] ?? 0,
      category: categoryData != null
          ? CategoryModel.fromJson(categoryData)
          : CategoryModel.defaultCategory(), // Default category if null
      // If null, // Default empty list if services is null
    );
  }
}

class CategoryModel {
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

  CategoryModel({
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

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      type: json['type'] ?? '',
      description: json['description'],
      image: json['image'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      popular: json['popular'] ?? 0,
      isSubCategories: json['is_sub_categories'] ?? false,
      subCategory: json['sub_category'] ?? [],
    );
  }

  factory CategoryModel.defaultCategory() {
    return CategoryModel(
      id: 0,
      name: 'Unknown',
      type: 'Unknown',
      description: null,
      image: '',
      status: 0,
      createdAt: '',
      updatedAt: '',
      popular: 0,
      isSubCategories: false,
      subCategory: [],
    );
  }
}

class ServiceModel {
  final int id;
  final int shopId;
  final String name;
  final String? description;
  final int active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot pivot;

  ServiceModel({
    required this.id,
    required this.shopId,
    required this.name,
    this.description,
    required this.active,
    this.createdAt,
    this.updatedAt,
    required this.pivot,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      shopId: json['shop_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      active: json['active'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'name': name,
      'description': description,
      'active': active,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  final int productId;
  final int serviceId;
  final String price;

  Pivot({
    required this.productId,
    required this.serviceId,
    required this.price,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      productId: json['product_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      price: json['price'] ?? '0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'service_id': serviceId,
      'price': price,
    };
  }
}





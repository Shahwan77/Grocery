class AjProduct {
  final int id;
  final String name;
  final String? description;
  final int status;
  final String? barcode;
  final String? packaging;
  final String price;
  final String image;
  final dynamic discount;
  final dynamic discountType;
  final dynamic discountValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AjProduct({
    required this.id,
    required this.name,
    this.description,
    required this.status,
    this.barcode,
    this.packaging,
    required this.price,
    required this.image,
    this.discount,
    this.discountType,
    this.discountValue,
    this.createdAt,
    this.updatedAt,
  });

  factory AjProduct.fromJson(Map<String, dynamic> json) {
    return AjProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      barcode: json['barcode'],
      packaging: json['packaging'],
      price: json['price'],
      image: json['image'],
      discount: json['discount'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

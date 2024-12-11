class Orderview {
  final bool success;
  final OrderData data;

  Orderview({required this.success, required this.data});

  factory Orderview.fromJson(Map<String, dynamic> json) {
    return Orderview(
      success: json['success'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
  final int id;
  final String orderId;
  final String orderDate;
  final int userId;
  final int? staffId;
  final String type;
  final String? collectionDate;
  final String? collectionTimeFrom;
  final String? collectionTimeTo;
  final String? deliveryDate;
  final String timeSlotFrom;
  final String timeSlotTo;
  final String? paymentMethod;
  final String? paymentChange;
  final int totalCount;
  final String totalAmount;
  final String deliveryCharge;
  final String status;
  final String? isConfirmed;
  final String createdAt;
  final String updatedAt;
  final List<OrderItem> items;

  OrderData({
    required this.id,
    required this.orderId,
    required this.orderDate,
    required this.userId,
    this.staffId,
    required this.type,
    this.collectionDate,
    this.collectionTimeFrom,
    this.collectionTimeTo,
    this.deliveryDate,
    required this.timeSlotFrom,
    required this.timeSlotTo,
    this.paymentMethod,
    this.paymentChange,
    required this.totalCount,
    required this.totalAmount,
    required this.deliveryCharge,
    required this.status,
    this.isConfirmed,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<OrderItem> items = itemsList.map((i) => OrderItem.fromJson(i)).toList();

    return OrderData(
      id: json['id'],
      orderId: json['order_id'],
      orderDate: json['order_date'],
      userId: json['user_id'],
      staffId: json['staff_id'],
      type: json['type'],
      collectionDate: json['collection_date'],
      collectionTimeFrom: json['collection_time_from'],
      collectionTimeTo: json['collection_time_to'],
      deliveryDate: json['delivery_date'],
      timeSlotFrom: json['time_slot_from'],
      timeSlotTo: json['time_slot_to'],
      paymentMethod: json['payment_method'],
      paymentChange: json['payment_change'],
      totalCount: json['total_count'],
      totalAmount: json['total_amount'],
      deliveryCharge: json['delivery_charge'],
      status: json['status'],
      isConfirmed: json['is_confirmed'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      items: items,
    );
  }
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String? price;
  final String status;
  final Product product;
  final List<Service> services;
  final List<ReplaceItem> replaceItems;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    this.price,
    required this.status,
    required this.product,
    required this.services,
    required this.replaceItems,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    var servicesList = json['services'] as List? ?? [];
    List<Service> services = servicesList.map((i) => Service.fromJson(i)).toList();

    var replaceItemsList = json['replace_items'] as List? ?? [];
    List<ReplaceItem> replaceItems = replaceItemsList.map((i) => ReplaceItem.fromJson(i)).toList();

    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      status: json['status'],
      product: Product.fromJson(json['product']),
      services: services,
      replaceItems: replaceItems,
    );
  }
}

class Product {
  final int id;
  final String type;
  final String name;
  final String image;
  final String price;
  final String? barcode;
  final String? packaging;
  final int categoryId;
  final int? subcategoryId;
  final String? description;
  final int status;

  Product({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.price,
    this.barcode,
    this.packaging,
    required this.categoryId,
    this.subcategoryId,
    this.description,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      barcode: json['barcode'],
      packaging: json['packaging'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      description: json['description'],
      status: json['status'],
    );
  }
}

class ReplaceItem {
  final int id;
  final int shopId;
  final int itemId;
  final int replacementItemId;
  final int confirm;
  final String createdAt;
  final String updatedAt;

  ReplaceItem({
    required this.id,
    required this.shopId,
    required this.itemId,
    required this.replacementItemId,
    required this.confirm,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReplaceItem.fromJson(Map<String, dynamic> json) {
    return ReplaceItem(
      id: json['id'],
      shopId: json['shop_id'],
      itemId: json['item_id'],
      replacementItemId: json['replacement_item_id'],
      confirm: json['confirm'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Service {
  final int id;
  final int orderItemId;
  final int serviceId;
  final String price;
  final String createdAt;
  final String updatedAt;
  final ServiceDetails service;

  Service({
    required this.id,
    required this.orderItemId,
    required this.serviceId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      orderItemId: json['order_item_id'],
      serviceId: json['service_id'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      service: ServiceDetails.fromJson(json['service']),
    );
  }
}

class ServiceDetails {
  final int id;
  final String name;

  ServiceDetails({required this.id, required this.name});

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Order {
  final Delivery delivery;
  final Payment payment;
  final Total total;
  final List<Item> items;

  Order({required this.delivery, required this.payment, required this.total, required this.items});

  Map<String, dynamic> toJson() {
    return {
      'delivery': delivery.toJson(),
      'payment': payment.toJson(),
      'total': total.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class Delivery {
  final String date;
  final String timeSlot;

  Delivery({required this.date, required this.timeSlot});

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time_slot': timeSlot,
    };
  }
}

class Payment {
  final String method;
  final int? change;

  Payment({required this.method, this.change});

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'change': change,
    };
  }
}

class Total {
  final int count;
  final double amount;

  Total({required this.count, required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'amount': amount,
    };
  }
}

class Item {
  final int productId;
  final int quantity;

  Item({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}

class myOrder {
  final int id;
  final String orderId;
  final String deliveryDate;
  final String timeSlotFrom;
  final String timeSlotTo;
  final String paymentMethod;
  final String? paymentChange;
  final int totalCount;
  final String totalAmount;
  final String status; // New status property

  myOrder({
    required this.id,
    required this.orderId,
    required this.deliveryDate,
    required this.timeSlotFrom,
    required this.timeSlotTo,
    required this.paymentMethod,
    this.paymentChange,
    required this.totalCount,
    required this.totalAmount,
    required this.status, // Include status in the constructor
  });

  factory myOrder.fromJson(Map<String, dynamic> json) {
    return myOrder(
      id: json['id'],
      orderId: json['order_id'],
      deliveryDate: json['delivery_date'],
      timeSlotFrom: json['time_slot_from'],
      timeSlotTo: json['time_slot_to'],
      paymentMethod: json['payment_method'],
      paymentChange: json['payment_change'],
      totalCount: json['total_count'],
      totalAmount: json['total_amount'],
      status: json['status'], // Extract status from JSON
    );
  }
}


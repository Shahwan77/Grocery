class NotificationModel {
  final int id;
  final String? orderId; // Nullable since the order_id can be null
  final String message;
  final String datetime;

  NotificationModel({
    required this.id,
    this.orderId,  // Make this optional
    required this.message,
    required this.datetime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      orderId: json['order_id'], // Can be null
      message: json['message'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId, // Will be null if not set
      'message': message,
      'datetime': datetime,
    };
  }
}

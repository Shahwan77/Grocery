// ice_cream_model.dart
class IceCreamModel {
  final String name;
  final String imagePath;
  final String price;

  IceCreamModel({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  // Method to create an IceCreamModel instance from JSON
  factory IceCreamModel.fromJson(Map<String, dynamic> json) {
    return IceCreamModel(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      price:json['price'] as String,
    );
  }

  // Method to convert IceCreamModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      'price' : price,
    };
  }
}
// ice_cream_data.dart
final List<IceCreamModel> iceCreamItems = [
  IceCreamModel(name: 'Vanilla', imagePath: 'assets/cat1.png', price: '1.95 AED'),
  IceCreamModel(name: 'Chocolate', imagePath: 'assets/cat1.png', price: '0.80 AED'),
  IceCreamModel(name: 'Strawberry', imagePath: 'assets/cat1.png', price: '1.42 AED'),
  IceCreamModel(name: 'Mint', imagePath: 'assets/cat1.png', price: '1.02 AED'),
];

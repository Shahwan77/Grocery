// item_model.dart
class ItemModel {
  final String name;
  final String imagePath;

  ItemModel({
    required this.name,
    required this.imagePath,
  });

  // Method to create an ItemModel instance from JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  // Method to convert ItemModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
    };
  }
}
// item_data.dart

final List<ItemModel> items = [
  ItemModel(name: 'FROZEN ICE CREAM', imagePath: 'assets/cat1.png'),
  ItemModel(name: 'ORGANIC &\nHEALTHY FOOD', imagePath: 'assets/cat2.png'),
  ItemModel(name: 'BAKERY PRODUCTS', imagePath: 'assets/cat3.png'),
  ItemModel(name: 'FRUITS &\n VEGETABLES', imagePath: 'assets/cat4.png'),
  ItemModel(name: 'DAIRY & EGGS', imagePath: 'assets/cat5.png'),
  ItemModel(name: 'TEA & COFFEE', imagePath: 'assets/cat6.png'),
  ItemModel(name: 'WATER & DRINK', imagePath: 'assets/cat7.png'),
  ItemModel(name: 'SOFT DRINKS &\nENERGY DRINKS', imagePath: 'assets/cat8.png'),
  ItemModel(name: 'JUICES', imagePath: 'assets/cat9.png'),
  ItemModel(name: 'BREAKFAST\nCEREALS', imagePath: 'assets/cat10.png'),
  ItemModel(name: 'BISCUITS & CRACKERS', imagePath: 'assets/cat11.png'),
  ItemModel(name: 'CHOCOLATES &\nCANDIES', imagePath: 'assets/cat12.png'),
];

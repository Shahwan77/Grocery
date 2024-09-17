class OrganicItem {
  final int id;
  final String name;
  final String image;
  final String price;

  OrganicItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory OrganicItem.fromJson(Map<String, dynamic> json) {
    return OrganicItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
    );
  }
}

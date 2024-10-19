class OrganicModel {
  final String name;
  final String imagePath;
 // final String price;

  OrganicModel({
    required this.name,
   // required this.price,
    required this.imagePath,
  });

  // Method to create an IceCreamModel instance from JSON
  factory  OrganicModel.fromJson(Map<String, dynamic> json) {
    return  OrganicModel(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      //price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      //'price' : price
    };
  }
}
// ice_cream_data.dart
final List< OrganicModel> organicItems = [
  OrganicModel(name: 'Kid Fashion', imagePath: 'assets/kid.png', ),
  OrganicModel(name: 'watches', imagePath: 'assets/watch.png', ),
  OrganicModel(name: 'Eyewear', imagePath: 'assets/eyewear.png',),
  OrganicModel(name: 'Sports', imagePath: 'assets/sports.png',),
  OrganicModel(name: 'Automotive', imagePath: 'assets/automative.png',),
  OrganicModel(name: 'Stationery', imagePath: 'assets/stationery.png',),
  OrganicModel(name: 'Books', imagePath: 'assets/books.png',),
  OrganicModel(name: 'Men Fashion', imagePath: 'assets/men.png', ),
  OrganicModel(name: 'Gift Card', imagePath: 'assets/giftcard.png',),
  OrganicModel(name: 'Baby gear', imagePath: 'assets/babygear.png'),
  OrganicModel(name: 'Home & Kitchen', imagePath: 'assets/kitchen.png'),
  OrganicModel(name: 'Large Appliances', imagePath: 'assets/largeappliances.png'),
  OrganicModel(name: 'Health & nutrition', imagePath: 'assets/health.png'),
  OrganicModel(name: 'Fragrance', imagePath: 'assets/pefumes.png'),
  OrganicModel(name: 'Personal care', imagePath: 'assets/cat2.png'),
  OrganicModel(name: 'Furniture', imagePath: 'assets/furniture.png'),
  OrganicModel(name: "Men's fashion", imagePath: 'assets/men.png',),
   OrganicModel(name: "Women's fashion", imagePath: 'assets/women.png'),
  OrganicModel(name: 'Mobiles & accessories', imagePath: 'assets/mobile.png'),
  OrganicModel(name: 'Electronics', imagePath: 'assets/electronics.png'),
  OrganicModel(name: 'Gaming essentials', imagePath: 'assets/gaming.png'),
  OrganicModel(name: 'Beauty', imagePath: 'assets/beauty.png'),
  OrganicModel(name: 'Grocery', imagePath: 'assets/grocery.png'),
  OrganicModel(name: 'Laptops & accessories', imagePath: 'assets/laptops.png'),
  OrganicModel(name: 'Small Appliances', imagePath: 'assets/smallappliances.png'),
  OrganicModel(name: 'Toys & Games', imagePath: 'assets/toys.png'),
  OrganicModel(name: 'Baby Care', imagePath: 'assets/babycare.png'),
];
final imageUrls = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHH9k5BBM5urnhkWzfgx3DGPYt85EYmDeUy2Ozi_8q9DsCsvS6',
  'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTJgy0S6K2YOZaOQ78fhJ2NJ8SPo_j998shURv_cRFzbMv6D5mg',
  'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTlgUe4KMSz8UulvfoRTQlIXaRdA43NGAmGxcrkND26TBULMRMI',
];
final text1=[
  'Family Harvest Rice Cakesn with Sea Salt-Non GM...',
  'Family Harvest Rice Cakesn with corn-gluten free...',
  'Family Harvest Rice Cakesn Original-Non GM...'
];
final Price1=[
  '9.01 AED',
  '9.01 AED',
  '4.50 AED',
];
final mstImage = [
  'assets/cat16.png',
  'assets/cat17.png',
  'assets/cat18.png',
  'assets/cat18.png',
];

final msttext=[
  'Lip Balm 2X7Gm',
  'Dr Rashel Vitamin C Lip Balm Aloe Vera 3Gm',
  'Labello Watermelon Shine Moisturizing Lip Balm',
  'Labello Watermelon Shine Moisturizing Lip Balm',
];
final mstPrice=[
  '2.95 AED',
  '7.95 AED',
  '14.50 AED',
  '14.50 AED',
];
final popImage = [
  'assets/cat20.png',
  'assets/cat21.png',
  'assets/cat22.png',
  'assets/cat23.png',
  'assets/cat24.png',
  'assets/cat25.png',
  'assets/cat26.png',
  'assets/cat27.png',
  'assets/cat28.png',
  'assets/cat29.png',
  'assets/cat30.png',
  'assets/cat31.png',
  'assets/cat32.png',
  'assets/cat33.png',
  'assets/cat34.png',
];
final poptext=[
  'Onion 250Gm',
  'Tomato 250Gm',
  'Potato Loose 250Gm',
  'Cucumber Loose(Gcc) 250Gm',
  'Coriander Leaf Pp',
  'Banana Small (India) 250GM',
  'Orange Valencia 250GM',
  'Mango Pakistan 500Gm',
  'Banana loose(Ripe)250Gm',
  'Coconut Shredded Fresh (Grated)Pp',
  'Banana Chiquitta(Ripe) 250Gm',
  'Banana india 250Gm',
  'Kangkong',
  'Carrot(China) 500Gm',
  'Blueberry Per Pack',
];
final popPrice=[
  '1.24 AED',
  '1.49 AED',
  'O.99 AED',
  '1.99 AED',
  '0.95 AED',
  '2.24 AED',
  '1.24 AED',
  '4.97 AED',
  '1.74 AED',
  '2.95 AED',
  '1.49 AED',
  '2.24 AED',
  '0.95 AED',
  '3.48 AED',
  '8.95 AED',
];
final topImage = [
  'assets/cat19.png',
];
final topPrice=[
'35.00 AED',
];
final toptext = [
  'Honey Cake 500GM'
];

final promo = [
  'assets/gro2.png',
  'assets/gro3.png',
  'assets/gro4.png',
];
class Api {
  static String BaseUrl = 'https://grocery-dev.greendomains.in';
  static String ImageUrl = '$BaseUrl/storage/images';
  static String Category= '$BaseUrl/api/product-categories';
  static String Product= '$BaseUrl/api/products';
  static String CategoryProduct= '$BaseUrl/api/products?category_id=2';
  static String PopularProduct='$BaseUrl/api/products/popular';
  static String DiscountProduct='$BaseUrl/api/products/discount';
  static String PopularCategories='$BaseUrl/api/product-categories/popular';

}
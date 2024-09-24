class Api {
  static String BaseUrl = 'https://grocery-dev.greendomains.in';
  static String ApiUrl = '$BaseUrl/api';
  static String ImageUrl = '$BaseUrl/storage/images';
  static String Category= '$ApiUrl/product-categories';
  static String Product= '$ApiUrl/products';
  static String CategoryProduct= '$ApiUrl/products?category_id';
  static String PopularProduct='$ApiUrl/products/popular';
  static String DiscountProduct='$ApiUrl/products/discount';
  static String PopularCategories='$ApiUrl/product-categories/popular';
  static String Login = '$ApiUrl/login';
  static String CartPost = '$ApiUrl/cart';
  static String CartGet = '$ApiUrl/cart';
}

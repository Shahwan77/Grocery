class Api {
  static String BaseUrl = 'https://grocery-dev.greendomains.in';
  static String ApiUrl = '$BaseUrl/api';
  static String ImageUrl = '$BaseUrl/storage/images';
  static String Category= '$ApiUrl/product-categories?type=grocery';
  static String Product= '$ApiUrl/products';
  static String CategoryProduct= '$ApiUrl/products?category_id';
  static String PopularProduct='$ApiUrl/products/popular';
  static String DiscountProduct='$ApiUrl/products/discount';
  static String PopularCategories='$ApiUrl/product-categories/popular';
  static String Login = '$ApiUrl/login';
  static String CartPost = '$ApiUrl/carts';
  static String CartGetgrocery = '$ApiUrl/carts?shop_id=1&type=grocery';
  static String CartGetlaundry = '$ApiUrl/carts?shop_id=1&type=laundry';
  static String CartRemove = '$ApiUrl/carts/remove';
  static String Order = '$ApiUrl/orders';
  static String MyOrderlaundry = '$ApiUrl/order?type=laundry';
  static String MyOrdergrocery = '$ApiUrl/order?type=grocery';
  static String Logout = '$ApiUrl/logout';
  static String User = '$ApiUrl/user';
  static String Register = '$ApiUrl/register';
  static String CategoryLaundry= '$ApiUrl/product-categories?type=laundry';
}

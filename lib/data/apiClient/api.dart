import 'package:get_storage/get_storage.dart';

class Api {
  static String shopid = GetStorage().read('selected_shop_id');
  static String type = GetStorage().read('selectedButton') ?? 'grocery';
  static String BaseUrl = 'https://grocery-test.greendomains.in';
  // static String BaseUrl = 'https://grocery-dev.greendomains.in';
  static String ApiUrl = '$BaseUrl/api';
  static String ImageUrl = '$BaseUrl/storage/images';
  static String Category= '$ApiUrl/product-categories?type=grocery&shop_id=$shopid';
  static String Product= '$ApiUrl/products';
  static String CategoryProduct= '$ApiUrl/products?category_id';
  static String PopularProduct='$ApiUrl/products/popular?shop_id=$shopid&type=$type';
  static String DiscountProduct='$ApiUrl/products/discount?shop_id=$shopid&type=$type';
  static String PopularCategories='$ApiUrl/product-categories/popular?shop_id=$shopid&type=$type';
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
  static String CategoryLaundry= '$ApiUrl/product-categories?type=laundry&shop_id=$shopid';
// static String AdminOrdergrocery= '$ApiUrl/admin/orders?shop_id=1&type=grocery&status=unassigned';
// static String AdminOrderlaundry= '$ApiUrl/admin/orders?shop_id=1&type=laundry&status=unassigned';
// static String AdminInOrdergrocery= '$ApiUrl/admin/orders?shop_id=1&type=grocery&status=assigned';
// static String AdminInOrderlaundry= '$ApiUrl/admin/orders?shop_id=1&type=laundry&status=assigned';
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/apiClient/api.dart';
import 'Cart/cart_controller.dart';
import 'deals_controller.dart';

class DealsPage extends StatelessWidget {
  final DealController dealController = Get.put(DealController());

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final token = GetStorage().read('access_token');
    Map<int, RxInt> quantityMap = {};
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEB1C23),
        title: Text(
          'Deals',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: dealController.fetchDeals(), // Fetch deals data
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Failed to load deals.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: dealController.deals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10.h,
                //crossAxisSpacing: 10.w,
                //mainAxisExtent: GetStorage().read('selectedButton') == 'laundry' ? 220.h : 170.h,
                mainAxisExtent: 170.h,
              ),
              itemBuilder: (context, index) {
                final deal = dealController.deals[index];
                quantityMap.putIfAbsent(deal.product!.id, () => 1.obs);
                RxBool isSelected = false.obs;
                return GestureDetector(
                  onTap: () {
                    isSelected.value = !isSelected.value;
                    if (isSelected.value) {
                      String priceToPost = deal.price.toString();
                      if (deal.promotionPrice != null) {
                        priceToPost = deal.promotionPrice.toString(); // Use promotionPrice if it's not null
                      }
                      cartController.toggleCart(
                        null,
                        {}.toString(),
                        deal.product!.id,
                        deal.product!.name,
                        priceToPost,
                        deal.product!.image,
                        {},
                      );
                    }// Toggle the selected state
                  },
                  child: IntrinsicHeight(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.grey.shade400)],
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Stack(
                        children: [Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.favorite_border),
                                  Icon(Icons.info_outline),
                                ],
                              ),
                              Center(
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  height: 90.h,
                                  width: 90.w,
                                  '${Api.ImageUrl}/products/${deal.product?.image}',
                                ),
                              ),

                              Center(
                                child: Text(
                                  deal.product!.name,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (deal.promotionPrice == null
                                    // Display the regular price if no promotion price
                                        ? Text(
                                      '\AED ${deal.price}',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                    // If promotion price is not null, show both prices
                                        : Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\AED ${deal.price}',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          '\AED ${deal.promotionPrice}',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )),
                                    Obx(() {
                                      final isInLocalCart = cartController.isInCart(deal.product!.id);
                                      final isInServerCart = cartController.fetchedcartItems
                                          .any((fetchedItem) => fetchedItem['product_id'] == deal.product!.id);

                                      final isInCart = isInLocalCart || isInServerCart;
                                      String priceToPost = deal.price.toString();
                                      if (deal.promotionPrice != null) {
                                        priceToPost = deal.promotionPrice.toString(); // Use promotionPrice if it's not null
                                      }
                                      return GestureDetector(
                                        onTap: isInCart
                                            ? null
                                            : () {
                                          cartController.toggleCart(
                                            null,
                                            {}.toString(),
                                            deal.product!.id,
                                            deal.product!.name,
                                            priceToPost,
                                            deal.product!.image,
                                            {},
                                          );
                                        },
                                        child: Icon(
                                          isInCart
                                              ? Icons.shopping_cart
                                              : Icons.shopping_cart_outlined,
                                          color: isInCart ? Color(0xFFEB1C23) : Colors.grey,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                          Obx(() {
                            final quantity = quantityMap[deal.product!.id]!.value;
                            return isSelected.value
                                ? Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14.r),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                        ),
                                        onPressed: () {
                                          if (quantity > 1) {
                                            // Reduce the quantity by 1
                                            cartController.updateQuantity(deal.product!.id, -1);
                                            quantityMap[deal.product!.id]!.value = quantity - 1; // Update using .value
                                          } else {
                                            // If quantity is 1, remove the item from the cart
                                            final productId = deal.product!.id;
                                            if (token != null) {
                                              cartController.removeItemFromCart(productId);
                                              isSelected.value = false;
                                            } else {
                                              cartController.removeFromCart(
                                                deal.product!.name,
                                                (deal.product!.price ?? 0).toString(),
                                                deal.product!.image,
                                                deal.product!.id as String,
                                              );
                                              isSelected.value = false;
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      '${quantity}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14.r),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.green.shade800,
                                        ),
                                        onPressed: () {
                                          cartController.updateQuantity(deal.product!.id, 1);
                                          quantityMap[deal.product!.id]!.value = quantity + 1; // Update using .value
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                                : SizedBox.shrink();
                          }),
                    ]
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

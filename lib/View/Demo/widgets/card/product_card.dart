import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants.dart';
import '../../controller/cart_provider.dart';
import '../../imports.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../../view/cart/cart.dart';
import '../text/text_builder.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final cart = Provider.of<CartProvider>(context);
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 0.5),
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: InkWell(
        onTap: () => openImage(context, size),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.sp)),
                child: CachedNetworkImage(
                  imageUrl: product.photoUrl ?? 'https://via.placeholder.com/150',
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                      color: AppColors.primary,
                    ), // Show progress bar here
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeInDuration: const Duration(milliseconds: 300),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextBuilder(
                      text: product.title ?? 'No Title', // Fallback for null title
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextBuilder(
                        text: product.category?.title ?? 'No Category', // Fallback for null category title
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const TextBuilder(
                              text: '₹ ',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            TextBuilder(
                              text: product.price?.round().toString() ?? '0', // Fallback for null price
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 4, // Adds a shadow for depth
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Rounded corners
                            ),
                            splashFactory: InkRipple.splashFactory,
                            foregroundColor: Colors.blue, // Interaction effect color
                            backgroundColor: AppColors.primary, // Transparent background
                          ),
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          child: Text(
                            'Rent',
                            style: TextStyle(
                              fontSize: 13.sp, // Assuming .sp is from a package like flutter_screenutil
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'PoppinsSemiBold',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            splashFactory: InkRipple.splashFactory,
                            foregroundColor: Colors.blue, // Controls the color for the splash effect and icon/text
                            backgroundColor: Colors.purple, // Background of the button
                            elevation: 0, // Removes default shadow for a flat look similar to TextButton
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Optional: Adjust border radius
                            ),
                          ),
                          onPressed: () {
                            if (product.id == null ||
                                product.title == null ||
                                product.price == null ||
                                product.photoUrl == null ||
                                product.category?.title == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: TextBuilder(text: 'Incomplete product data'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }
                            final ScaffoldMessengerState addToCartMsg = ScaffoldMessenger.of(context);
                            addToCartMsg.showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.black,
                                action: SnackBarAction(
                                  label: 'Go to Cart',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const Cart(appBar: 'Hone')),
                                    );
                                  },
                                ),
                                behavior: SnackBarBehavior.floating,
                                content: const TextBuilder(text: 'Product added to cart'),
                              ),
                            );
                            CartModel cartModel = CartModel(
                              id: product.id!,
                              title: product.title!,
                              price: product.price!,
                              image: product.photoUrl!,
                              category: product.category!.title,
                              quantity: 1,
                              totalPrice: product.price!,
                            );
                            cart.addItem(cartModel);
                          },
                          child: Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'PoppinsSemiBold',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openImage(BuildContext context, Size size) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(8),
          iconPadding: EdgeInsets.zero,
          elevation: 0,
          title: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBuilder(
                  text: product.title ?? 'No Title', // Fallback for null title
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          content: InteractiveViewer(
            minScale: 0.1,
            maxScale: 1.9,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.sp)),
              child: CachedNetworkImage(
                imageUrl: product.photoUrl ?? 'https://via.placeholder.com/150',
                height: size.height * 0.5,
                width: size.width,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                    color: AppColors.primary,
                  ), // Show progress bar here
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeInDuration: const Duration(milliseconds: 300),
              ),
            ),

          ),
        );
      },
    );
  }
}
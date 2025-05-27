import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospirent/constants.dart';
import '../../../../main.dart';
import '../../controller/cart_provider.dart';
import '../../imports.dart';
import '../../widgets/app_name_widget.dart';
import '../../widgets/card/cart_card.dart';
import '../../widgets/text/text_builder.dart';
import '../drawer/drawer_menu.dart';

class Cart extends StatefulWidget {
  final String appBar;
  const Cart({super.key, required this.appBar});

  @override
  // ignore: library_private_types_in_public_api
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.backgroud,
      appBar: widget.appBar != ''
          ? AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const AppNameWidget(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.sp),
            bottomRight: Radius.circular(20.sp),
          ),
        ),
        leading: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(8.0), // Adjust padding as needed
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24, // Set grey background for drawer icon
                shape: BoxShape.circle, // Optional: makes the background circular
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white), // Drawer icon
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Opens the drawer
                },
              ),
            ),
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black),
              child: TextBuilder(
                text: cart.itemCount.toString(),
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ],
      )
          : null,
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: cart.items.isEmpty
            ? Center(
          child: AnimatedOpacity(
            opacity: cart.items.isEmpty ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100.sp,
                  color: Colors.grey,
                ),
                SizedBox(height: 20.h),
                TextBuilder(
                  text: 'Your Cart is Empty!',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(height: 10.h),
                TextBuilder(
                  text: 'Add some items to get started.',
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
                SizedBox(height: 20.h),
                MaterialButton(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  MainScreen(initialIndex: 0,)));

                  },
                  child: TextBuilder(
                    text: 'Shop Now',
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
            : ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: cart.items.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return CartCard(cart: cart.items[i]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0);
          },
        ),
      ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 60,
          color: Colors.black,
          minWidth: size.width,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            final ScaffoldMessengerState buyNow =
            ScaffoldMessenger.of(context);
            buyNow.showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
                content:
                const TextBuilder(text: 'Thank you for shopping with us'),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBuilder(
                  text: '₹ ${cart.totalPrice()}',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
              const SizedBox(width: 10.0),
              const TextBuilder(
                text: 'Pay Now',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
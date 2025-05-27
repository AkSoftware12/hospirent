import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospirent/constants.dart';
import 'package:provider/provider.dart';

import '../../Demo/controller/cart_provider.dart';
import '../../Demo/view/drawer/drawer_menu.dart';
import '../../Demo/widgets/app_name_widget.dart';
import '../../Demo/widgets/text/text_builder.dart';


class XRayAtHomeScreen extends StatelessWidget {
  const XRayAtHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor:AppColors.backgroud,
      appBar:
          AppBar(
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
      ),

      drawer: const DrawerMenu(),
      body:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: const Text(
              'X-Ray At Home',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          // Image Section with Overlay
          Stack(
            children: [
              // Placeholder for the image
              Image.network(
                'https://hospirent.in/public//storage/photos/services/x%20ray.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ],
          ),
          // Buttons
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Call Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Section
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Experience the Convenience of X-Ray Services in the Comfort of Your Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'At Hospirent, we understand that your health is of utmost importance, and we’re committed to making medical diagnostics more accessible and convenient for you. That’s why we’re thrilled to introduce our “X-Ray at Home” service, bringing state-of-the-art diagnostic imaging directly to your doorstep.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Why Choose X-Ray at Home?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '1. Comfort and Convenience: No need to travel to a hospital or imaging center.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Expandable Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
              color: Color(0xFFF9F9F9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Why Choose X-Ray at Home?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Image.network(
                      'https://via.placeholder.com/20x20?text=Star',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
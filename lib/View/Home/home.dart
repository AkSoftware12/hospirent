import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hospirent/HexColor.dart';

import '../../constants.dart';
import '../Demo/controller/cart_provider.dart';
import '../Demo/imports.dart';
import '../Demo/view/home/home.dart';

// // Assuming constants.dart defines AppColors
// class AppColors {
//   static const background = Color(0xFFF5F7FA); // Light grey background
//   static const primary = Color(0xFF3B82F6); // Vibrant blue
//   static const accent = Color(0xFFFF6B6B); // Coral accent
//   static const cardBackground = Colors.white;
//   static const gradient = LinearGradient(
//     colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Sample data for carousel images
  final List<Map<String, String>> bannerImages = [
    {'url': 'https://hospirent.in/public//storage/photos/banner/banner111.png', 'title': 'Explore New Deals!'},
    {'url': 'https://hospirent.in/public//storage/photos/banner/banner2.png', 'title': 'Shop Now!'},
    {'url': 'https://hospirent.in/public//storage/photos/banner/banner3.png', 'title': 'Exclusive Offers!'},
  ];

  // Sample categories
  final List<Map<String, dynamic>> categories = [
    {'name': 'Oxygen Cylinders', 'icon': 'https://hospirent.in/public//storage/photos/products_category/oxygen-tube_7128867.png', 'semanticsLabel': 'Electronics', 'color': Colors.blue},
    {'name': 'Wheelchairs', 'icon': 'https://hospirent.in/public//storage/photos/products_category/wheelchair_5255796.png', 'semanticsLabel': 'Fashion', 'color': Colors.pink},
    {'name': 'Hospital Beds	', 'icon':'https://hospirent.in/public//storage/photos/products_category/hospital-bed_3209103.png', 'semanticsLabel': 'Home', 'color': Colors.green},
    {'name': 'Medical & Surgical Products', 'icon':'https://hospirent.in/public//storage/photos/products_category/medical%20produt.png', 'semanticsLabel': 'Beauty', 'color': Colors.purple},
    {'name': 'BiPAP Machines	', 'icon':'https://hospirent.in/public//storage/photos/products_category/Bipap%20Machine.png', 'semanticsLabel': 'Sports', 'color': Colors.orange},
    {'name': 'Oxygen Concentrators	', 'icon': 'https://hospirent.in/public//storage/photos/products_category/freezer_2676740.png', 'semanticsLabel': 'Books', 'color': Colors.teal},
  ];

  final List<Map<String, dynamic>> services = [
    {'name': 'X-ray At Home	', 'icon': 'https://hospirent.in/public//storage/icons/services/scan_3387759.png', 'semanticsLabel': 'Electronics', 'color': Colors.blue},
    {'name': 'Dialysis At Home', 'icon': 'https://hospirent.in/public//storage/icons/services/human_10192287.png', 'semanticsLabel': 'Fashion', 'color': Colors.pink},
    {'name': 'Home Nursing', 'icon':'https://hospirent.in/public//storage/icons/services/nurse_2719553.png', 'semanticsLabel': 'Home', 'color': Colors.green},
    {'name': 'ECG At Home', 'icon':'https://hospirent.in/public//storage/icons/services/life-line_2875045.png', 'semanticsLabel': 'Beauty', 'color': Colors.purple},
    {'name': 'ECG Holter', 'icon':'https://hospirent.in/public//storage/icons/services/ecgholter.png', 'semanticsLabel': 'Sports', 'color': Colors.orange},
    {'name': 'Neurotherapy', 'icon': 'https://hospirent.in/public//storage/icons/services/neurotherapy.png', 'semanticsLabel': 'Books', 'color': Colors.teal},
    {'name': 'Natural Therapy', 'icon': 'https://hospirent.in/public//storage/icons/services/naturaltherapy.png', 'semanticsLabel': 'Books', 'color': Colors.teal},
    {'name': 'Rental Ambulance', 'icon': 'https://hospirent.in/public//storage/icons/services/ambulance.png', 'semanticsLabel': 'Books', 'color': Colors.teal},
    {'name': 'Equipment Repairing	', 'icon': 'https://hospirent.in/public//storage/icons/services/equipment%20repairing.png', 'semanticsLabel': 'Books', 'color': Colors.teal},
    {'name': 'Sleep Study', 'icon': 'https://hospirent.in/public//storage/icons/services/sleepstudy.png', 'semanticsLabel': 'Books', 'color': Colors.teal},
  ];

  // // Sample services
  // final List<Map<String, dynamic>> services = [
  //   {'name': 'Repair', 'description': 'Fix your devices quickly', 'icon': Icons.build, 'semanticsLabel': 'Repair'},
  //   {'name': 'Delivery', 'description': 'Fast and reliable delivery', 'icon': Icons.local_shipping, 'semanticsLabel': 'Delivery'},
  //   {'name': 'Consulting', 'description': 'Expert advice for you', 'icon': Icons.support_agent, 'semanticsLabel': 'Consulting'},
  // ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroud,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              // Enhanced Banner Slider
              _buildBannerSlider(),
              SizedBox(height: 10.h),
              // Category Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  'Explore Categories',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(duration: 600.ms, curve: Curves.easeInOut),
              ),
              SizedBox(height: 12.h),
              _buildCategoryGrid(),
              SizedBox(height: 10.h),
              // Service Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(duration: 600.ms, curve: Curves.easeInOut),
              ),
              SizedBox(height: 12.h),
              _buildServiceGrid(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerSlider() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 120.h, // Increased height for prominence
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 1, // Slightly smaller for side peek
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: bannerImages.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    // Add navigation or action for banner tap
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped ${banner['title']}')),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: banner['url']!,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: 50.sp,
                              color: AppColors.accent,
                              semanticLabel: 'Image load error',
                            ),
                          ),
                          // Gradient overlay for text readability
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 800.ms, curve: Curves.easeInOut);
              },
            );
          }).toList(),
        ),
        // Dot Indicators
        Positioned(
          bottom: 8.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bannerImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = entry.key),
                child: Container(
                  width: _currentIndex == entry.key ? 12.w : 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key ? AppColors.primary : Colors.white.withOpacity(0.5),
                  ),
                ).animate().scale(duration: 400.ms, curve: Curves.easeInOut),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    const crossAxisCount = 3; // Number of columns
    const crossAxisSpacing = 5.0; // Horizontal spacing between items
    const mainAxisSpacing = 5.0; // Vertical spacing between items
    const childAspectRatio = 0.85; // Width-to-height ratio of each item

    // Calculate number of rows
    final int rowCount = (categories.length / crossAxisCount).ceil();

    // Calculate item width based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - (2 * 8.w) - (crossAxisCount - 1) * crossAxisSpacing.w) / crossAxisCount;

    // Calculate item height based on aspect ratio
    final double itemHeight = itemWidth / childAspectRatio;

    // Calculate total height: (item height * number of rows) + (spacing between rows) + padding
    final double totalHeight = (itemHeight * rowCount) + (mainAxisSpacing.h * (rowCount - 1)) + (2 * 12.h);

    return Padding(
      padding:  EdgeInsets.all(5.sp),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));

            },
            child: Card(
              elevation: 0,
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      categories[index]['color'].withOpacity(0.1),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.all(1.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.sp,
                        child: Image.network(
                          categories[index]['icon'],
                          // size: 48.sp,
                          // color: categories[index]['color'],
                          semanticLabel: categories[index]['semanticsLabel'],
                        ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        categories[index]['name'],
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().slideY(
              begin: 0.3,
              end: 0.0,
              duration: 600.ms,
              delay: (100 * index).ms,
              curve: Curves.easeOut,
            ).fadeIn(duration: 600.ms),
          );
        },
      ),
    );
  }

  Widget _buildServiceGrid() {
    const crossAxisCount = 3; // Number of columns
    const crossAxisSpacing = 5.0; // Horizontal spacing between items
    const mainAxisSpacing = 5.0; // Vertical spacing between items
    const childAspectRatio = 0.85; // Width-to-height ratio of each item

    // Calculate number of rows
    final int rowCount = (categories.length / crossAxisCount).ceil();

    // Calculate item width based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth - (2 * 8.w) - (crossAxisCount - 1) * crossAxisSpacing.w) / crossAxisCount;

    // Calculate item height based on aspect ratio
    final double itemHeight = itemWidth / childAspectRatio;

    // Calculate total height: (item height * number of rows) + (spacing between rows) + padding
    final double totalHeight = (itemHeight * rowCount) + (mainAxisSpacing.h * (rowCount - 1)) + (2 * 12.h);

    return Padding(
      padding:  EdgeInsets.all(5.sp),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${services[index]['name']}')),
              );
            },
            child: Card(
              elevation: 0,
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#68b1e8'),
                  borderRadius: BorderRadius.circular(16.r),
                  // gradient: LinearGradient(
                  //   colors: [
                  //     services[index]['color'].withOpacity(0.1),
                  //     Colors.white,
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.all(1.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.sp,
                        child: Image.network(
                          services[index]['icon'],
                          // size: 48.sp,
                          // color: categories[index]['color'],
                          semanticLabel: services[index]['semanticsLabel'],
                        ).animate().scale(duration: 300.ms, curve: Curves.easeInOut),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        services[index]['name'],
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().slideY(
              begin: 0.3,
              end: 0.0,
              duration: 600.ms,
              delay: (100 * index).ms,
              curve: Curves.easeOut,
            ).fadeIn(duration: 600.ms),
          );
        },
      ),
    );
  }

  Widget _buildServiceList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Add navigation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped ${services[index]['name']}')),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              leading: CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  services[index]['icon'],
                  color: AppColors.primary,
                  size: 28.sp,
                  semanticLabel: services[index]['semanticsLabel'],
                ),
              ),
              title: Text(
                services[index]['name'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                services[index]['description'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ).animate().slideX(
            begin: 0.2,
            end: 0.0,
            duration: 600.ms,
            delay: (100 * index).ms,
            curve: Curves.easeOut,
          ).fadeIn(duration: 600.ms),
        );
      },
    );
  }
}
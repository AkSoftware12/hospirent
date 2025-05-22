import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hospirent/HexColor.dart';

import '../Demo/view/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _scrollController = ScrollController();

  // Banner data
  final List<Map<String, String>> bannerImages = [
    {
      'url': 'https://hospirent.in/public//storage/photos/banner/banner111.png',
      'title': 'Explore New Deals!'
    },
    {
      'url': 'https://hospirent.in/public//storage/photos/banner/banner2.png',
      'title': 'Shop Now!'
    },
    {
      'url': 'https://hospirent.in/public//storage/photos/banner/banner3.png',
      'title': 'Exclusive Offers!'
    },
  ];

  // Categories data
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Oxygen Cylinders',
      'icon':
      'https://hospirent.in/public//storage/photos/products_category/oxygen-tube_7128867.png',
      'color': Colors.blue
    },
    {
      'name': 'Wheelchairs',
      'icon':
      'https://hospirent.in/public//storage/photos/products_category/wheelchair_5255796.png',
      'color': Colors.pink
    },
    {
      'name': 'Hospital Beds',
      'icon':
      'https://hospirent.in/public//storage/photos/products_category/hospital-bed_3209103.png',
      'color': Colors.green
    },
    {
      'name': 'Medical & Surgical Products',
      'icon':
      'https://hospirent.in/public//storage/photos/products_category/medical%20produt.png',
      'color': Colors.purple
    },
    {
      'name': 'BiPAP Machines',
      'icon':
      'https://hospirent.in/public//storage/photos/products_category/Bipap%20Machine.png',
      'color': Colors.orange
    },
    {
      'name': 'Oxygen Concentrators',
      'icon':
      'https://hospirent.in/public//storage/photos/products_category/freezer_2676740.png',
      'color': Colors.teal
    },
  ];

  // Services data
  final List<Map<String, dynamic>> services = [
    {
      'name': 'X-ray At Home',
      'icon':
      'https://hospirent.in/public//storage/icons/services/scan_3387759.png',
      'color': Colors.blue
    },
    {
      'name': 'Dialysis At Home',
      'icon':
      'https://hospirent.in/public//storage/icons/services/human_10192287.png',
      'color': Colors.pink
    },
    {
      'name': 'Home Nursing',
      'icon':
      'https://hospirent.in/public//storage/icons/services/nurse_2719553.png',
      'color': Colors.green
    },
    {
      'name': 'ECG At Home',
      'icon':
      'https://hospirent.in/public//storage/icons/services/life-line_2875045.png',
      'color': Colors.purple
    },
    {
      'name': 'ECG Holter',
      'icon':
      'https://hospirent.in/public//storage/icons/services/ecgholter.png',
      'color': Colors.orange
    },
    {
      'name': 'Neurotherapy',
      'icon':
      'https://hospirent.in/public//storage/icons/services/neurotherapy.png',
      'color': Colors.teal
    },
    {
      'name': 'Natural Therapy',
      'icon':
      'https://hospirent.in/public//storage/icons/services/naturaltherapy.png',
      'color': Colors.teal
    },
    {
      'name': 'Rental Ambulance',
      'icon':
      'https://hospirent.in/public//storage/icons/services/ambulance.png',
      'color': Colors.teal
    },
    {
      'name': 'Equipment Repairing',
      'icon':
      'https://hospirent.in/public//storage/icons/services/equipment%20repairing.png',
      'color': Colors.teal
    },
    {
      'name': 'Sleep Study',
      'icon':
      'https://hospirent.in/public//storage/icons/services/sleepstudy.png',
      'color': Colors.teal
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _buildBannerSlider().animate().fadeIn(duration: 500.ms),
          ),

          // Categories Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle('Explore Categories'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildCategoryItem(index),
                childCount: categories.length,
              ),
            ),
          ),

          // Services Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle('Our Services'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildServiceItem(index),
                childCount: services.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.blue[900],
      ),
    ).animate().slideX(
      begin: -0.2,
      end: 0,
      duration: 500.ms,
      curve: Curves.easeOutCubic,
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(height: 3.h),

        CarouselSlider.builder(
          itemCount: bannerImages.length,
          options: CarouselOptions(
            height: 120.h,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: 5.seconds,
            viewportFraction: 0.99,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: bannerImages[index]['url']!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.blue[200]!),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.broken_image,
                        size: 40.sp,
                        color: Colors.grey[300],
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.bottomCenter,
                    //       end: Alignment.topCenter,
                    //       colors: [
                    //         Colors.black.withOpacity(0.6),
                    //         Colors.transparent,
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 16.h,
                    //   left: 16.w,
                    //   child: Text(
                    //     bannerImages[index]['title']!,
                    //     style: TextStyle(
                    //       fontSize: 18.sp,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //       shadows: [
                    //         Shadow(
                    //           blurRadius: 6.0,
                    //           color: Colors.black,
                    //           offset: Offset(2.0, 2.0),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            bannerImages.length,
                (index) => AnimatedContainer(
              duration: 300.ms,
              width: _currentIndex == index ? 24.w : 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: _currentIndex == index
                    ? Colors.blue[800]
                    : Colors.grey[400],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));

        // Handle category tap
        // _showSnackBar('Selected: ${categories[index]['name']}');
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
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
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60.sp,
                  height: 60.sp,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: categories[index]['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: categories[index]['icon'],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                            categories[index]['color']),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: categories[index]['color'],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  categories[index]['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ).animate().scaleXY(
        begin: 0.8,
        end: 1,
        duration: 500.ms,
        delay: (100 * index).ms,
        curve: Curves.easeOutBack,
      ),
    );
  }

  Widget _buildServiceItem(int index) {
    return InkWell(
      onTap: () {
        // Handle service tap
        _showSnackBar('Selected: ${services[index]['name']}');
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: HexColor('#68b1e8').withOpacity(0.1),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60.sp,
                  height: 60.sp,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: services[index]['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: services[index]['icon'],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        AlwaysStoppedAnimation(services[index]['color']),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: services[index]['color'],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  services[index]['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ).animate().slideY(
        begin: 0.5,
        end: 0,
        duration: 500.ms,
        delay: (50 * index).ms,
        curve: Curves.easeOutQuad,
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
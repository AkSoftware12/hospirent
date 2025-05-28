import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hospirent/HexColor.dart';
import 'package:hospirent/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Demo/view/home/home.dart';
import 'Services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _scrollController = ScrollController();

  List<dynamic> categories = []; // Declare a list to hold API data
  List<dynamic> product = []; // Declare a list to hold API data
  List<dynamic> services = []; // Declare a list to hold API data
  List<dynamic> banner = []; // Declare a list to hold API data
  bool isLoading = true;

  // Banner data
  final List<Map<String, String>> bannerImages = [
    {
      'url': 'assets/banner111.png',
      'title': 'Explore New Deals!'
    },
    {
      'url': 'assets/banner2.png',
      'title': 'Shop Now!'
    },

  ];

  final List<Map<String, dynamic>> categories1 = [
    {
      'color': Colors.blue
    },
    {
      'color': Colors.pink
    },
    {
      'color': Colors.green
    },
    {
      'color': Colors.purple
    },
    {
      'color': Colors.orange
    },
    {
      'color': Colors.teal
    },
  ];
  final List<Map<String, dynamic>> topService = [
    {
      'name': 'All \n Product',
      'icon': 'assets/product.png',
      'color': Colors.blue
    },
    {
      'name': 'All \n Service',
      'icon': 'assets/services.png',
      'color': Colors.pink
    },
    {
      'name': 'Book Ambulance',
      'icon': 'assets/van2.png',
      'color': Colors.green
    },
    {
      'name': 'Nursing \n Staff',
      'icon': 'assets/nursing.png',
      'color': Colors.purple
    },

  ];
  final List<Map<String, dynamic>> services1 = [
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.blue
    },
    {
      'color': Colors.pink
    },
    {
      'color': Colors.green
    },
    {
      'color': Colors.purple
    },
    {
      'color': Colors.orange
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
    {
      'color': Colors.teal
    },
  ];

  final List<Map<String, dynamic>> countItem = [
    {
      'name': 'Nursing Staff',
      'count': '450+',
      'icon': 'assets/doc.png',
      'color': Colors.orangeAccent
    },
    {
      'name': 'Happy Patients',
      'count': '10000+',
      'icon': 'assets/patients.png',
      'color': Colors.blueGrey
    },
    {
      'name': 'Medical Equipments',
      'count': '700+',
      'icon': 'assets/patients.png',
      'color': Colors.redAccent
    },
    {
      'name': 'Years Of Experience',
      'count': '20+',
      'icon': 'assets/awards.png',
      'color': Colors.blueAccent
    },

  ];

  final List<Map<String, dynamic>> bottomService = [
    {
      'name': 'Largest Inventory',
      'icon': 'assets/chooseImg1.png',
      'color': Colors.white
    },
    {
      'name': 'Genuine Products',
      'icon': 'assets/chooseImg2.png',
      'color': Colors.white
    },
    {
      'name': 'Patient Counselling',
      'icon': 'assets/chooseImg3.png',
      'color': Colors.white
    },
    {
      'name': 'Rental Facility',
      'icon': 'assets/chooseImg4.png',
      'color': Colors.white
    },
    {
      'name': 'Pick-up Facility',
      'icon': 'assets/chooseImg5.png',
      'color': Colors.white
    },
    {
      'name': 'Offers and Discounts',
      'icon': 'assets/chooseImg6.png',
      'color': Colors.white
    },

  ];

  @override
  void initState() {
    super.initState();
    fetchDasboardData();
    fetchProductData();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Future<void> fetchDasboardData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print("Token: $token");


      final response = await http.get(
        Uri.parse(ApiRoutes.getDashboard),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Verify that data is a Map and contains the expected keys
        if (data is Map<String, dynamic>) {
          setState(() {
            // Use null-aware operators or provide default values
            categories = data['categories'] is List ? data['categories'] : [];
            services = data['services'] is List ? data['services'] : [];
            banner = data['banner'] ?? []; // Adjust based on expected type of banner
            isLoading = false;

            print("Categories: $categories");
            print("Services: $services");
            print("Banner: $banner");
          });
        } else {
          print("Error: Invalid response format");
          _showErrorDialog("Invalid response format from server");
        }
      } else {
        print("Error: Failed to fetch data, status code: ${response.statusCode}");
        _showErrorDialog("Failed to fetch dashboard data");
        // Optionally call _showLoginDialog() if status code is 401 (Unauthorized)
        if (response.statusCode == 401) {
        }
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
      _showErrorDialog("An error occurred while fetching data");
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> fetchProductData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print("Token: $token");


      final response = await http.get(
        Uri.parse(ApiRoutes.getAllProducts),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Verify that data is a Map and contains the expected keys
        if (data is Map<String, dynamic>) {
          setState(() {
            // Use null-aware operators or provide default values
            product = data['products'] is List ? data['products'] : [];

            isLoading = false;

            print("Categories: $product");

          });
        } else {
          print("Error: Invalid response format");
          _showErrorDialog("Invalid response format from server");
        }
      } else {
        print("Error: Failed to fetch data, status code: ${response.statusCode}");
        _showErrorDialog("Failed to fetch dashboard data");
        // Optionally call _showLoginDialog() if status code is 401 (Unauthorized)
        if (response.statusCode == 401) {
        }
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
      _showErrorDialog("An error occurred while fetching data");
      setState(() {
        isLoading = false;
      });
    }
  }

// Example error dialog method
  void _showErrorDialog(String message) {
    // Implement your dialog logic here, e.g., using showDialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

// Assuming _showLoginDialog is already defined elsewhere
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  HexColor('c6d7eb'),
      backgroundColor:  AppColors.backgroud,
      body: isLoading
          ?  Center(
        child: CupertinoActivityIndicator(radius: 20,color: AppColors.primary,),
      )
          : CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _buildBannerSlider().animate().fadeIn(duration: 500.ms),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: HexColor('192067').withOpacity(0.7),
                elevation: 4, // Adjust elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w), // Inner padding for the card
                  child: CustomScrollView(
                    shrinkWrap: true, // Prevents unbounded height issues
                    physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.w,
                          mainAxisSpacing: 0.h,
                          childAspectRatio: 2.5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) => _buildAllServiceItem(index),
                          childCount: topService.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Categories Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle('Explore Categories'),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.h),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: HexColor('316879'),
                elevation: 4, // Adjust elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w), // Inner padding for the card
                  child: CustomScrollView(
                    shrinkWrap: true, // Prevents unbounded height issues
                    physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                    slivers: [
                      SliverGrid(
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
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Services Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle('Our Services'),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.h),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: HexColor('6883bc'),
                elevation: 4, // Adjust elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w), // Inner padding for the card
                  child: CustomScrollView(
                    shrinkWrap: true, // Prevents unbounded height issues
                    physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                    slivers: [
                      SliverGrid(
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
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: HexColor('#ededed'),
                margin: EdgeInsets.zero,
                elevation: 4, // Adjust elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.r), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.w), // Inner padding for the card
                  child: CustomScrollView(
                    shrinkWrap: true, // Prevents unbounded height issues
                    physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                        sliver: SliverToBoxAdapter(
                          child: Center(child: _buildSectionTitle('Featured Products')),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 200.h, // Adjust height based on your item size
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w), // Mimics mainAxisSpacing
                              child: Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.6, // Adjust width based on your item size
                                child: _buildProductItem(index),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            sliver: SliverToBoxAdapter(
              child: Center(child: _buildSectionTitle('ABOUT HOSPIRENT')),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            sliver: SliverToBoxAdapter(
              child: Center(child: _buildSectionSUBTitle('Led by Sachin Verma,'
                  ' HospirentOnline is a pioneer in the culture of professional'
                  ' high-quality and personalized healthcare. \n \nHospirentOnline has been able to provide quality healthcare to thousand/lack of people in the 11 years. After leaving the work for 20 years of experience I decided to name HospirentOnline we are a nonprofit organization that helps seniors and young through collaboration with that associate. We help deliver solution to seniors for their most important needs.')),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
            sliver: SliverToBoxAdapter(
              child: Image.network('https://hospirent.in/public//storage/photos/logo/post-3-img.jpg',fit: BoxFit.fill,)),
            ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
            sliver: SliverToBoxAdapter(
              child: Card(
                color: HexColor('320d3e').withOpacity(0.7),
                margin: EdgeInsets.zero,
                elevation: 4, // Adjust elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.r), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w), // Inner padding for the card
                  child: CustomScrollView(
                    shrinkWrap: true, // Prevents unbounded height issues
                    physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.w,
                          mainAxisSpacing: 0.h,
                          childAspectRatio: 1.2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) => _buildAllCountItem(index),
                          childCount: countItem.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
            sliver: SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200.sp,
                        child: Image.network('https://hospirent.in/public/frontend/hospirentImages/featureBannerImg.jpg',fit: BoxFit.fill,)),
                    Padding(
                      padding:  EdgeInsets.all(15.sp),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width* 0.7,
                        child: Text('Extensive Product Range: \n\nWe are providing high-quality, reliable Hospital Equipment', style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: 'PoppinsBold',
                        ),),
                      ),
                    )
                  ],
                )),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            sliver: SliverToBoxAdapter(
              child: Center(child: _buildSectionTitle('Why Choose Us')),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            sliver: SliverToBoxAdapter(
              child: Center(child: _buildSectionSUBTitle(''
                  'At Hospirent, we understand thecritical role that top-quality hospital equipment plays in delivering exceptionalhealthcare. '
                  ' high-quality and personalized healthcare. \n \nOur extensive inventory, combined with our unwavering commitment to customer satisfaction, makes us the preferred partner forhealthcare facilities seeking reliable and cost-effective equipment solutions.')),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(2.w), // Inner padding for the card
                child: CustomScrollView(
                  shrinkWrap: true, // Prevents unbounded height issues
                  physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the card
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0.w,
                        mainAxisSpacing: 0.h,
                        childAspectRatio: 4,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildAllBottomItem(index),
                        childCount: bottomService.length,
                      ),
                    ),
                  ],
                ),
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
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'PoppinsBold',
      ),
    ).animate().slideX(
      begin: -0.2,
      end: 0,
      duration: 500.ms,
      curve: Curves.easeOutCubic,
    );
  }
  Widget _buildSectionSUBTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: 'PoppinsRegular',
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
                    Image.asset(
                      bannerImages[index]['url']!,
                      fit: BoxFit.fill,
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child; // Image is already loaded
                        }
                        return frame != null
                            ? child // Image loaded successfully
                            : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Color(0xFFBBDEFB)), // Colors.blue[200]
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.broken_image,
                        size: 40.sp, // Assuming you're using a package like flutter_screenutil for .sp
                        color: Colors.grey[300],
                      ),
                    )

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
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home(id: categories[index]['id'],)));

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
                categories1[index]['color'].withOpacity(0.1),
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
                    color:  categories1[index]['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: categories[index]['photo_url'],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                            categories1[index]['color']),
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
                  categories[index]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontFamily: 'PoppinsBold',
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
  Widget _buildAllServiceItem(int index) {
    return InkWell(
      onTap: () {

        if(index==0){
          Navigator.push(context, MaterialPageRoute(builder: (_) => Home(id: 0,)));

        }

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
                topService[index]['color'].withOpacity(0.1),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: Row(
              children: [
                Container(
                  width: 60.sp,
                  height: 60.sp,
                  padding: EdgeInsets.all(0.sp),
                  child: Image.asset(
                    topService[index]['icon'].toString(),
                    fit: BoxFit.contain, // Ensure the image fits within the container
                  ),
                ),
                // SizedBox(width: 8.h),
                Expanded( // Use Expanded to constrain the Text widget
                  child: Text(
                    topService[index]['name'].toString().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                      fontFamily: 'PoppinsBold',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        )
      ).animate().scaleXY(
        begin: 0.8,
        end: 1,
        duration: 500.ms,
        delay: (100 * index).ms,
        curve: Curves.easeOutBack,
      ),
    );
  }

  Widget _buildAllBottomItem(int index) {
    return InkWell(
      onTap: () {

      },
      borderRadius: BorderRadius.circular(0.r),
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.r),
              gradient: LinearGradient(
                colors: [
                  bottomService[index]['color'].withOpacity(0.1),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: Row(
                children: [
                  Container(
                    width: 50.sp,
                    height: 50.sp,
                    padding: EdgeInsets.all(5.sp),
                    child: Image.asset(
                      bottomService[index]['icon'].toString(),
                      fit: BoxFit.contain, // Ensure the image fits within the container
                    ),
                  ),
                  SizedBox(width: 20.h),
                  Expanded( // Use Expanded to constrain the Text widget
                    child: Text(
                      bottomService[index]['name'].toString().toUpperCase(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                        fontFamily: 'PoppinsBold',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
      ).animate().scaleXY(
        begin: 0.8,
        end: 1,
        duration: 500.ms,
        delay: (100 * index).ms,
        curve: Curves.easeOutBack,
      ),
    );
  }


  Widget _buildAllCountItem(int index) {
    return InkWell(
      onTap: () {
      },
      borderRadius: BorderRadius.circular(0.r),
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
                  countItem[index]['color'].withOpacity(0.1),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50.sp,
                    height: 50.sp,
                    padding: EdgeInsets.all(0.sp),
                    child: Image.asset(
                      countItem[index]['icon'].toString(),
                      fit: BoxFit.contain, // Ensure the image fits within the container
                    ),
                  ),
                  // SizedBox(width: 8.h),
                  Expanded( // Use Expanded to constrain the Text widget
                    child: Column(
                      children: [
                        SizedBox(height: 5.sp,),
                        Text(
                          countItem[index]['count'].toString().toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            fontFamily: 'PoppinsBold',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          countItem[index]['name'].toString().toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                            fontFamily: 'PoppinsBold',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => XRayAtHomeScreen()));
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
                    color: services1[index]['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: services[index]['icon_url'],
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
                      color: services1[index]['color'],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  services[index]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontFamily: 'PoppinsBold',
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

  Widget _buildProductItem(int index) {
    return InkWell(
      onTap: () {
      },
      borderRadius: BorderRadius.circular(16.r),
      child: CachedNetworkImage(
        imageUrl: product[index]['photo_url'],
        fit: BoxFit.contain,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor:
            AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error_outline,
        ),
      ),
    );
  }

}
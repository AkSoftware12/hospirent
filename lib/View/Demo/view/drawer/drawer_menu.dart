import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospirent/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../HexColor.dart';
import '../../../../main.dart';
import '../../../DrawerScreen/ContactUs.dart';
import '../../../DrawerScreen/privacy.dart';
import '../../../DrawerScreen/terms.dart';
import '../../../Home/Services/services.dart';
import '../../../Profile/profile.dart';
import '../../const/raw_string.dart';
import '../../imports.dart';
import '../../utils/url_launch.dart';
import '../../widgets/app_name_widget.dart';
import '../../widgets/text/text_builder.dart';
import '../cart/cart.dart';
import '../home/home.dart';
import 'package:http/http.dart' as http;

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  List<dynamic> categories = []; // Declare a list to hold API data
  List<dynamic> product = []; // Declare a list to hold API data
  List<dynamic> services = []; // Declare a list to hold API data
  List<dynamic> banner = []; // Declare a list to hold API data
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchDasboardData();

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
        }
      } else {
        print("Error: Failed to fetch data, status code: ${response.statusCode}");
        // Optionally call _showLoginDialog() if status code is 401 (Unauthorized)
        if (response.statusCode == 401) {
        }
      }
    } catch (e) {
      print("Error fetching dashboard data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.primary,
        child: Column(
          children: [
            // Top Header: Full width
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              color: Colors.blue.shade800,
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(RawString.appLogoURL),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBuilder(
                          text: RawString.appName,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        TextBuilder(
                          text: RawString.dummyEmail,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items: take full remaining space
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 10.sp,),
                  _drawerItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 0,)));

                      }),
                  // _drawerItem(
                  //     icon: Icons.production_quantity_limits,
                  //     label: 'All Product',
                  //     onTap: () {
                  //
                  //         Navigator.push(context, MaterialPageRoute(builder: (_) => Home(id: 0,)));
                  //
                  //
                  //
                  //     }),

                  CustomExpansionTile(
                    icon: Icons.category,
                    text: 'Products',
                    height: 30.sp, // custom height of collapsed tile
                    children: [
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return _buildCategorySubItem(context,
                                categories[index]['title'].toString(),
                                categories[index]['photo_url'].toString(),
                                categories[index]['id'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),



                  CustomExpansionTile(
                    icon: Icons.info_outline,
                    text: 'Services',
                    height: 30.sp, // custom height of collapsed tile
                    children: [
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            return _buildSubItem(context, services[index]['title'].toString(),services[index]['icon_url'].toString());
                          },
                        ),
                      ),
                    ],
                  ),


                  _drawerItem(
                      icon: Icons.shopping_cart,
                      label: 'Cart',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 3,)));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => const Cart(appBar: 'Cart')));
                      }),
                  _drawerItem(
                      icon: Icons.person, label: 'Profile', onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 4,)));

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => const ProfileScreen(appBar: 'Profile')));
                  }),


                  _drawerItem(
                      icon: Icons.article,
                      label: 'Blogs',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 1,)));


                      }),
                  _drawerItem(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 2,)));

                      }),

                  _drawerItem(
                      icon: Icons.description,
                      label: 'Terms & Conditions',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen(
                              lastUpdated: 'May 27, 2025',
                              version: '1.0.0',
                              sections:[
                                {
                                  "title": "1. Introduction",
                                  "content": "Welcome to our application. By using our services, you agree to these Terms and Conditions. Please read them carefully. These terms govern your access to and use of our platform, including any content, functionality, and services offered."
                                },
                                {
                                  "title": "2. User Responsibilities",
                                  "content": "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account."
                                },
                                {
                                  "title": "3. Prohibited Activities",
                                  "content": "You may not use our services for any illegal or unauthorized purpose. This includes, but is not limited to, violating any applicable laws, transmitting harmful code, or engaging in activities that interfere with the operation of our services."
                                },
                                {
                                  "title": "4. Intellectual Property",
                                  "content": "All content provided through our services, including text, graphics, logos, and software, is the property of the company or its licensors and is protected by intellectual property laws. You may not reproduce, distribute, or create derivative works without permission."
                                },
                                {
                                  "title": "5. Termination",
                                  "content": "We reserve the right to terminate or suspend your account at our sole discretion, without prior notice, for conduct that we believe violates these Terms or is harmful to other users or third parties."
                                },
                                {
                                  "title": "6. Rental Service and Non-Refundable Policy",
                                  "content": "Our application offers a rental service for products such as furniture, equipment, or vehicles ('Rental Products'). By renting products through our platform, you agree to the following conditions, including a strict non-refundable policy for all payments: 1. All rental payments, including fees and deposits, are non-refundable unless otherwise stated in writing by us. 2. You must provide valid identification (e.g., Aadhaar, passport, or driver’s license) at the time of booking, which will be verified before product delivery. 3. A refundable security deposit is required, which will be returned within 7-10 business days after the rental period, subject to a quality check confirming no damage to the product. 4. You are responsible for returning the Rental Product in the same condition as received, excluding normal wear and tear; any damage will result in deduction from the security deposit. 5. The minimum rental period is three months, and early termination does not entitle you to a refund of rental fees. 6. You must not sublet, transfer, or allow unauthorized use of the Rental Product by third parties. 7. Products must be used only for their intended purpose and in compliance with all applicable laws and regulations. 8. Late returns will incur a penalty fee of 10% of the daily rental rate per day, deducted from the security deposit. 9. You are responsible for any additional costs, such as cleaning fees (minimum INR 200) if the product is returned in poor condition, or repair costs for damages caused by misuse. 10. We reserve the right to cancel your rental booking if you fail to meet eligibility requirements (e.g., valid ID, payment, or credit check), with no refund of any prepaid amounts. 11. Delivery and pickup of Rental Products are subject to availability and may incur additional fees if your location lacks elevator access or requires special handling. 12. You must notify us at least 48 hours in advance for any changes to the rental agreement, such as extending the rental period; failure to do so may result in additional charges or forfeiture of the rental. These terms ensure a fair and efficient rental process for all users."
                                },
                                {
                                  "title": "7. Payment Terms",
                                  "content": "All payments for rental services must be made through the approved payment methods on our platform. You agree to provide accurate billing information and authorize us to charge the specified amounts. Late payments may result in additional fees or suspension of services."
                                },
                                {
                                  "title": "8. Limitation of Liability",
                                  "content": "To the fullest extent permitted by law, we are not liable for any indirect, incidental, or consequential damages arising from your use of our services, including loss of profits, data, or property damage, even if advised of the possibility of such damages."
                                },
                                {
                                  "title": "9. Privacy Policy",
                                  "content": "We collect and process personal information in accordance with our Privacy Policy. By using our services, you consent to the collection, use, and sharing of your data as outlined therein, including for verification and service delivery purposes."
                                },
                                {
                                  "title": "10. Governing Law",
                                  "content": "These Terms and Conditions are governed by the laws of India. Any disputes arising under these terms will be subject to the exclusive jurisdiction of the courts located in [Your City], India."
                                }
                              ],

                            ),
                          ),
                        );

                      }),
                  _drawerItem(
                      icon: Icons.privacy_tip,
                      label: 'Privacy Policy',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PrivacyPage()));

                      }),
                  _drawerItem(
                      icon: Icons.contact_mail,
                      label: 'Contact Us',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContactUsPage()));
                      }),
                  // _drawerItem(
                  //     icon: Icons.info_outline,
                  //     label: 'About App',
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //       showAboutDialog(
                  //         context: context,
                  //         applicationName: RawString.appName,
                  //         applicationVersion: '1.0.0+1',
                  //       );
                  //     }),
                  _drawerItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      onTap: () {
                        Navigator.pop(context);
                        // your logout logic here
                      }),
                ],
              ),
            ),

            // Bottom Footer: Full width
            Container(
              width: double.infinity,
              color: Colors.blueGrey.shade900,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                children: [
                  const AppNameWidget(),
                  const SizedBox(height: 6),
                  TextBuilder(
                    text: RawString.appDescription,
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.all(8.sp),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white,size: 24.sp,),
              SizedBox(width: 10.sp,),

              Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'PoppinsSemiBold',
                ),

                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            ],
          ),
        ),
      ),
    );

  }



  // Build the expansion item (no top/bottom lines)
  Widget _buildExpansionItem({
    required IconData icon,
    required String text,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(
        icon,
        size: 24.sp,
        color:Colors.white,
      ),
      title:   Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'PoppinsSemiBold',
        ),

        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      childrenPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white, // color when collapsed

      children: children,
      // trailing: Icon(CupertinoIcons.chevron_down,
      // size: 24.sp,
      //   color:Colors.white,
      // ),

    );
  }

  // Build the sub-item (renders HTML content)
  Widget _buildSubItem(BuildContext context, String content, String image) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Padding(
        padding: EdgeInsets.only(left: 28.sp, bottom: 5.sp),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => XRayAtHomeScreen()));

          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 22.sp,
                height: 22.sp,
                padding: EdgeInsets.all(3.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 8.sp),
              Expanded(
                child: Text(
                  content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'PoppinsMedium',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCategorySubItem(BuildContext context, String content, String image,int id) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Padding(
        padding: EdgeInsets.only(left: 28.sp, bottom: 5.sp),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => Home(id: id,)));

          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 22.sp,
                height: 22.sp,
                padding: EdgeInsets.all(3.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 8.sp),
              Expanded(
                child: Text(
                  content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'PoppinsMedium',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class CustomExpansionTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final List<Widget> children;
  final double height;

  const CustomExpansionTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.children,
    this.height = 60.0, // default collapsed height
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _handleTap,
          child: Container(
            height: widget.height.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              // color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'PoppinsSemiBold',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    Icons.expand_more,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

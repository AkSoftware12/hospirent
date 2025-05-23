import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospirent/constants.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'MyOrders/my_orders/my_orders.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late List<Animation<Offset>> _slideAnimations;
  bool _isDarkMode = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Fix: Adjusted interval calculation to ensure end <= 1.0
    _slideAnimations = List.generate(
      6,
          (index) => Tween<Offset>(
        begin: const Offset(0.5, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index / 6), // Start: Spread evenly from 0.0 to 0.833
            (index / 6) + (1.0 - index / 6) * 0.8, // End: Max at 1.0
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
        const NetworkImage('https://randomuser.me/api/portraits/women/68.jpg'),
        context,
      );
    });

    _controller.addStatusListener((status) {
      print("Animation status: $status");
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("ProfileScreen build called");
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroud,
      body: Column(
        children: [
          // Header section
          Container(
            height: screenSize.height * 0.15,
            child: _buildHeader(context, screenSize, theme),
          ),
          // ListView
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 7, // 6 tiles + 1 logout button
              itemBuilder: (context, index) {
                if (index == 6) {
                  return _buildLogoutButton(context);
                }
                final tileData = [
                  {
                    'title': 'My Orders',
                    'subtitle': '12 completed orders',
                    'icon': Iconsax.shopping_bag,
                    'iconColor': Colors.pink,
                    'onTap': () => _navigateWithBounce(context, 'Orders'),
                  },
                  {
                    'title': 'Shipping Addresses',
                    'subtitle': '3 saved locations',
                    'icon': Iconsax.location,
                    'iconColor': Colors.teal,
                    'onTap': () => _navigateWithBounce(context, '/addresses'),
                  },
                  {
                    'title': 'Payment Methods',
                    'subtitle': 'Visa •••• 7854',
                    'icon': Iconsax.card,
                    'iconColor': Colors.purple,
                    'onTap': () => _navigateWithBounce(context, '/payment_methods'),
                  },
                  {
                    'title': 'Promocodes',
                    'subtitle': 'You have 5 promos',
                    'icon': Iconsax.tag,
                    'iconColor': Colors.orange,
                    'onTap': () => _navigateWithBounce(context, '/promocodes'),
                  },
                  {
                    'title': 'My Reviews',
                    'subtitle': '12 product reviews',
                    'icon': Iconsax.star,
                    'iconColor': Colors.amber,
                    'onTap': () => _navigateWithBounce(context, '/reviews'),
                  },
                  {
                    'title': 'Settings',
                    'subtitle': 'Privacy & notifications',
                    'icon': Iconsax.setting,
                    'iconColor': Colors.blue,
                    'onTap': () => _navigateWithBounce(context, '/settings'),
                  },
                ];
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimations[index],
                    child: _buildAnimatedListTile(
                      context,
                      title: tileData[index]['title'] as String,
                      subtitle: tileData[index]['subtitle'] as String,
                      icon: tileData[index]['icon'] as IconData,
                      iconColor: tileData[index]['iconColor'] as Color,
                      slideAnimation: _slideAnimations[index],
                      onTap: tileData[index]['onTap'] as VoidCallback,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(context),
        backgroundColor: _isDarkMode ? Colors.indigo[800] : Colors.indigo,
        child:  Icon(Iconsax.edit, color: Colors.white),
        elevation: 6,
      ),
    );
  }

  void _navigateWithBounce(BuildContext context, String route) {
    if (_isNavigating) return;
    _isNavigating = true;

    if (route == 'Orders') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrders()));
    } else {
      Navigator.pushNamed(context, route);
    }
    HapticFeedback.lightImpact();

    Future.delayed(const Duration(milliseconds: 500), () {
      _isNavigating = false;
    });
  }

  Widget _buildHeader(BuildContext context, Size screenSize, ThemeData theme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'profile-avatar',
                child: GestureDetector(
                  onTap: () => _showAvatarZoom(context),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
                          memCacheHeight: 200,
                          memCacheWidth: 200,
                          placeholder: (context, url) => CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Iconsax.user,
                            size: 30,
                            color: Colors.black,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50.sp,
                right: 0,
                child: GestureDetector(
                  onTap: () => _openEditProfile(context),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.indigo.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Iconsax.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Matilda Brown",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "matildabrown@mail.com",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openEditProfile(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen()));
  }

  void _showAvatarZoom(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Hero(
          tag: 'profile-avatar',
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
                memCacheHeight: 400,
                memCacheWidth: 400,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Iconsax.user,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedListTile(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color iconColor,
        required Animation<Offset> slideAnimation,
        required VoidCallback onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        elevation: 2,
        shadowColor: _isDarkMode ? Colors.black : Colors.grey.withOpacity(0.2),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          splashColor: Colors.indigo.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Iconsax.arrow_circle_right,
                  color: Colors.indigo,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _showLogoutConfirmation(context),
          splashColor: Colors.red.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _isDarkMode ? Colors.red[800]! : Colors.red,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.logout,
                  color: _isDarkMode ? Colors.red[400] : Colors.red,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: _isDarkMode ? Colors.red[400] : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit Profile",
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Profile updated successfully!"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Log Out",
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Logged out successfully!"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
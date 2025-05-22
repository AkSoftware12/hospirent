import 'package:flutter/material.dart';
import 'package:hospirent/app_colors.dart';
import 'package:hospirent/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late List<Animation<Offset>> _slideAnimations;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Staggered slide animations for each list tile
    _slideAnimations = List.generate(
      6, // Number of list tiles
          (index) => Tween<Offset>(
        begin: const Offset(0.5, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 * index,
            0.1 * index + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroud,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section with Fade Animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const NetworkImage(
                        'https://example.com/user-image.jpg',
                      ),
                      onBackgroundImageError: (error, stackTrace) => const Icon(Icons.person, size: 40),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Matilda Brown",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "matildabrown@mail.com",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            // List of Options with Slide Animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  _buildAnimatedListTile(
                    context,
                    title: "My Orders",
                    subtitle: "Already have 12 orders",
                    icon: Icons.shopping_bag_outlined,
                    slideAnimation: _slideAnimations[0],
                    onTap: () {
                      // Navigate to orders screen
                    },
                  ),
                  _buildAnimatedListTile(
                    context,
                    title: "Shipping Addresses",
                    subtitle: "3 addresses",
                    icon: Icons.location_on_outlined,
                    slideAnimation: _slideAnimations[1],
                    onTap: () {
                      // Navigate to shipping addresses screen
                    },
                  ),
                  _buildAnimatedListTile(
                    context,
                    title: "Payment Methods",
                    subtitle: "Visa ***34",
                    icon: Icons.credit_card_outlined,
                    slideAnimation: _slideAnimations[2],
                    onTap: () {
                      // Navigate to payment methods screen
                    },
                  ),
                  _buildAnimatedListTile(
                    context,
                    title: "Promocodes",
                    subtitle: "You have special promocodes",
                    icon: Icons.local_offer_outlined,
                    slideAnimation: _slideAnimations[3],
                    onTap: () {
                      // Navigate to promocodes screen
                    },
                  ),
                  _buildAnimatedListTile(
                    context,
                    title: "My Reviews",
                    subtitle: "Reviews for 4 items",
                    icon: Icons.star_border,
                    slideAnimation: _slideAnimations[4],
                    onTap: () {
                      // Navigate to reviews screen
                    },
                  ),
                  _buildAnimatedListTile(
                    context,
                    title: "Settings",
                    subtitle: "Password, notifications",
                    icon: Icons.settings_outlined,
                    slideAnimation: _slideAnimations[5],
                    onTap: () {
                      // Navigate to settings screen
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Animated ListTile with Scale and Slide Animations
  Widget _buildAnimatedListTile(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Animation<Offset> slideAnimation,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: slideAnimation,
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ScaleTap(
              onTap: onTap,
              child: ListTile(
                leading: Icon(icon, color: theme.primaryColor),
                title: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom widget for scale animation on tap
class ScaleTap extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const ScaleTap({required this.onTap, required this.child, super.key});

  @override
  State<ScaleTap> createState() => _ScaleTapState();
}

class _ScaleTapState extends State<ScaleTap> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}
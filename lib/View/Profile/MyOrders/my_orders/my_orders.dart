import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants.dart';
import '../../../Demo/controller/cart_provider.dart';
import '../../../Demo/imports.dart';
import '../../../Demo/view/cart/cart.dart';
import '../../../Demo/view/drawer/drawer_menu.dart';
import '../../../Demo/widgets/app_name_widget.dart';
import '../../../Demo/widgets/text/text_builder.dart';

class Order {
  final String id;
  final String title;
  final String status;
  final double amount;
  final DateTime date;

  Order({
    required this.id,
    required this.title,
    required this.status,
    required this.amount,
    required this.date,
  });
}

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample order data
  final List<Order> orders = [
    Order(id: '1', title: 'Smartphone', status: 'Pending', amount: 599.99, date: DateTime.now().subtract(const Duration(days: 1))),
    Order(id: '2', title: 'Laptop', status: 'Completed', amount: 1299.99, date: DateTime.now().subtract(const Duration(days: 3))),
    Order(id: '3', title: 'Headphones', status: 'Canceled', amount: 99.99, date: DateTime.now().subtract(const Duration(days: 2))),
    Order(id: '4', title: 'Tablet', status: 'Pending', amount: 399.99, date: DateTime.now().subtract(const Duration(hours: 10))),
    Order(id: '5', title: 'Smartwatch', status: 'Completed', amount: 199.99, date: DateTime.now().subtract(const Duration(days: 5))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshOrders() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  List<Order> _getOrdersByStatus(String status) {
    return orders.where((order) => order.status == status).toList();
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      transform: Matrix4.identity()..scale(_isTapped(order.id) ? 0.95 : 1.0),
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 500 + index * 100),
        child: AnimatedSlide(
          offset: Offset(0, index * 0.05),
          duration: Duration(milliseconds: 600 + index * 100),
          curve: Curves.easeOutCubic,
          child: GestureDetector(
            onTapDown: (_) => setState(() => _tappedCardId = order.id),
            onTapUp: (_) => setState(() => _tappedCardId = null),
            onTapCancel: () => setState(() => _tappedCardId = null),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailScreen(order: order),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              elevation: 8,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[50]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Icon with Gradient
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: order.status == 'Pending'
                                ? [Colors.orange[400]!, Colors.orange[700]!]
                                : order.status == 'Completed'
                                ? [Colors.green[400]!, Colors.green[700]!]
                                : [Colors.red[400]!, Colors.red[700]!],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getOrderIcon(order.title),
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Order Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Semantics(
                              label: 'Order title: ${order.title}',
                              child: Text(
                                order.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Order ID: ${order.id}',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              'Amount: \$${order.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Date: ${DateFormat('MMM dd, yyyy').format(order.date)}',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      // Status Chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: order.status == 'Pending'
                                ? [Colors.orange[600]!, Colors.orange[900]!]
                                : order.status == 'Completed'
                                ? [Colors.green[600]!, Colors.green[900]!]
                                : [Colors.red[600]!, Colors.red[900]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          order.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _tappedCardId;

  bool _isTapped(String id) => _tappedCardId == id;

  IconData _getOrderIcon(String title) {
    switch (title.toLowerCase()) {
      case 'smartphone':
        return Icons.smartphone;
      case 'laptop':
        return Icons.laptop;
      case 'headphones':
        return Icons.headphones;
      case 'tablet':
        return Icons.tablet;
      case 'smartwatch':
        return Icons.watch;
      default:
        return Icons.shopping_bag;
    }
  }



  Widget _buildOrderList(String status) {
    final filteredOrders = _getOrdersByStatus(status);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: _buildContent(status, filteredOrders),
    );
  }

  Widget _buildContent(String status, List<dynamic> filteredOrders) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (filteredOrders.isEmpty) {
      return _buildEmptyState(status);
    }

    return _buildLoadedState(filteredOrders);
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      key: const ValueKey('loading'),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 5, // Consider making this dynamic based on expected data
      padding: EdgeInsets.symmetric(
        horizontal: 16.0 * (MediaQuery.of(context).size.width / 375), // Responsive padding
        vertical: 8.0,
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildShimmerCard(),
      ),
    );
  }

  Widget _buildEmptyState(String status) {
    return Padding(
      key: const ValueKey('empty'),
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 100.0 * (MediaQuery.of(context).size.width / 375), // Responsive icon size
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 24.0),
            Text(
              'No ${status.toLowerCase()} orders',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'You currently have no ${status.toLowerCase()} orders',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 180.0 * (MediaQuery.of(context).size.width / 375), // Responsive button width
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact(); // Add haptic feedback
                  _refreshOrders();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  elevation: 4,
                  shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Text(
                  'Refresh',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(List<dynamic> filteredOrders) {
    return RefreshIndicator(
      key: const ValueKey('loaded'),
      onRefresh: () async {
        HapticFeedback.lightImpact(); // Add haptic feedback
        await _refreshOrders();
      },
      color: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      displacement: 40.0,
      edgeOffset: 16.0,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: filteredOrders.length,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0 * (MediaQuery.of(context).size.width / 375), // Responsive padding
          vertical: 8.0,
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _buildOrderCard(filteredOrders[index], index),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabCounts = {
      'Pending': _getOrdersByStatus('Pending').length,
      'Completed': _getOrdersByStatus('Completed').length,
      'Canceled': _getOrdersByStatus('Canceled').length,
    };

    final cart = Provider.of<CartProvider>(context);


    return Scaffold(
      key: _scaffoldKey,

      drawer: const DrawerMenu(),
      backgroundColor: AppColors.backgroud,

      body:Column(
        children: [
          // Custom AppBar
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.sp),
                bottomRight: Radius.circular(20.sp),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30.sp),
            child: Column(
              children: [
                // Top row with menu icon, title and cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu icon

                   Builder(
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

                    // IconButton(
                    //   icon: Icon(Icons.menu, color: Colors.white),
                    //   onPressed: () {
                    //     _scaffoldKey.currentState?.openDrawer();
                    //
                    //   },
                    // ),

                    // Title
                    AppNameWidget(),

                    // Cart icon with badge
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart(appBar: 'Home',)));
                      },
                      icon: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: cart.itemCount != 0 ? 8 : 0, right: cart.itemCount != 0 ? 8 : 0),
                            child: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          if (cart.itemCount != 0)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 20,
                                width: 20,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                child: Text(
                                  cart.itemCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),

                // TabBar
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  indicatorColor: Colors.white,
                    dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  tabs: [
                    Tab(text: 'Pending (${tabCounts['Pending']})'),
                    Tab(text: 'Completed (${tabCounts['Completed']})'),
                    Tab(text: 'Canceled (${tabCounts['Canceled']})'),
                  ],
                ),
              ],
            ),
          ),

          // Your main content here
          Expanded(
            child:  TabBarView(
              key: ValueKey(_tabController.index),
              controller: _tabController,
              children: [
                _buildOrderList('Pending'),
                _buildOrderList('Completed'),
                _buildOrderList('Canceled'),
              ],
            ),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _refreshOrders,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

// Sample Order Detail Screen
class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${order.title} Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[700]!, Colors.purple[900]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Title: ${order.title}', style: const TextStyle(fontSize: 16)),
            Text('Status: ${order.status}', style: const TextStyle(fontSize: 16)),
            Text('Amount: \$${order.amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            Text('Date: ${DateFormat('MMM dd, yyyy').format(order.date)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
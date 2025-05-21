import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospirent/constants.dart';
import 'package:provider/provider.dart';
import 'View/Auth/Login/login.dart';
import 'View/Cart/cart.dart';
import 'View/Demo/controller/cart_provider.dart';
import 'View/Demo/view/cart/cart.dart';
import 'View/Demo/view/drawer/drawer_menu.dart';
import 'View/Demo/widgets/app_name_widget.dart';
import 'View/Demo/widgets/text/text_builder.dart';
import 'View/Home/home.dart';
import 'View/Product/product.dart';
import 'Widget/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return  MultiProvider(
            providers: [
            ChangeNotifierProvider<CartProvider>(create: (context) => CartProvider()),
            ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
        ],

          child: MaterialApp(
            title: 'Shopping App',
            theme: ThemeData(primarySwatch: Colors.blue),
            debugShowCheckedModeBanner: false,
            home: MainScreen(),
            routes: {
              '/login': (context) => LoginScreen(),
            },
          ),
        );
      },
    );
  }

}

class AuthProvider with ChangeNotifier {
  String? _user;
  String? _redirectRoute;

  String? get user => _user;
  String? get redirectRoute => _redirectRoute;

  void setRedirectRoute(String route) {
    _redirectRoute = route;
    notifyListeners();
  }

  bool login(String username, String password) {
    // Simulate login with hardcoded credentials
    if (username == 'test' && password == 'password123') {
      _user = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
    _redirectRoute = null;
    notifyListeners();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    ProductScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: const AppNameWidget(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.sp),
            bottomRight: Radius.circular(20.sp),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart()));
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
                      child: TextBuilder(
                        text: cart.itemCount.toString(),
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  )
              ],
            ),
          )
        ],

      ),


      drawer: const DrawerMenu(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
        backgroundColor: AppColors.primary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}






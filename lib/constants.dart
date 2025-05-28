import 'package:flutter/material.dart';
import 'HexColor.dart';


class AppColors {
  static  Color primary = HexColor('#034da2'); // Example primary color (blue)
  static  Color backgroud  = HexColor('#eef1f6'); // Example primary color (blue)
  static const Color grey = Color(0xFFAAAEB2); // Secondary color (gray)
  static const Color error = Color(0xFFDC3545); // Error color (red)
  static const Color success = Color(0xFF28A745);

  static const accent = Color(0xFFFF6B6B); // Coral accent
  static const cardBackground = Colors.white;
  static const gradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}

class AppAssets {
  static const String logo = 'assets/images/logo.png'; 
  static const String cjm = 'assets/cjm.png';
  static const String cjmlogo = 'assets/playstore.png';
}

class ApiRoutes {


  // Main App Url
  static const String baseUrl = "https://hospirent.in/api";


// Local  App Url


  // static const String baseUrl = "http://192.168.1.4/CJM/api";



  static const String login = "$baseUrl/login";
  static const String signup = "$baseUrl/signup";
  static const String logout = "$baseUrl/logout";
  static const String clear = "$baseUrl/clear";
  static const String getProfile = "$baseUrl/getProfile";
  static const String getUpdateProfile = "$baseUrl/updateProfile";
  static const String getUpdatePassword = "$baseUrl/updatePassword";


  static const String getDashboard = "$baseUrl/dashboard";
  // static const String getAllProducts = "$baseUrl/products";
  static const String getAllProducts = "$baseUrl/products?category_id=";
  static const String getAllServices = "$baseUrl/services";
  static const String getVideo = "$baseUrl/video";
  static const String getProductsDetail = "$baseUrl/products-detail?id=";




  static const String notifications = "$baseUrl/notifications";
}

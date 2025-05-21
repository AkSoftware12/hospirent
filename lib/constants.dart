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
  static const String baseUrl = "https://aone.akdesire.com/api";


// Local  App Url


  // static const String baseUrl = "http://192.168.1.4/CJM/api";



  static const String login = "$baseUrl/login";
  static const String logout = "$baseUrl/logout";
  static const String clear = "$baseUrl/clear";
  static const String getProfile = "$baseUrl/get-profile";
  static const String employeeCreate = "$baseUrl/admin/employee-create";


  static const String getEmployeeList = "$baseUrl/admin/employee-list";
  static const String getExpensesList = "$baseUrl/admin/expance-list";

  static const String getAllowanceList = "$baseUrl/admin/allowance-list";
  static const String updateAllowanceList = "$baseUrl/admin/allowance-update";
  static const String createAllowance = "$baseUrl/admin/allowance-create";
  static const String detailAllowance = "$baseUrl/admin/allowance";
  static const String deleteAllowanceList = "$baseUrl/admin/allowance-delete";


  static const String getDeductionList = "$baseUrl/admin/deduction-list";
  static const String deleteDeductionList  = "$baseUrl/admin/deduction-delete";
  static const String updateDeductionList= "$baseUrl/admin/deduction-update";
  static const String createDeduction = "$baseUrl/admin/deduction-create";




  static const String employeeDeductionList = "$baseUrl/admin/employee-deduction";
  static const String employeeDeductionStore = "$baseUrl/admin/employee-deduction-store";
  static const String employeeDeductionUpdate = "$baseUrl/admin/employee-deduction-update";
  static const String employeeAllowanceList = "$baseUrl/admin/employee-allowance";




  static const String getSalaryList = "$baseUrl/admin/salary-list";
  static const String genrateSalary = "$baseUrl/admin/salary-genrate";
  static const String genrateSlip = "$baseUrl/admin/salary-slip/";



  static const String getCategoryListExpanse = "$baseUrl/admin/category-list";
  static const String createExpenses = "$baseUrl/admin/expance-create";
  static const String createCategoryExpenses = "$baseUrl/admin/category-create";
  static const String deleteExpenses = "$baseUrl/admin/expance-delete";
  static const String deleteCategory = "$baseUrl/admin/category-delete";
  static const String updateExpenses = "$baseUrl/admin/expance-update";
  static const String updateCategory = "$baseUrl/admin/category-update";


  static const String getFundList = "$baseUrl/admin/fund-list";
  static const String deleteFund = "$baseUrl/admin/fund-delete";
  static const String createFund = "$baseUrl/admin/fund-create";
  static const String updateFund = "$baseUrl/admin/fund-update";



  static const String getAllotmentList = "$baseUrl/admin/recovery-list";
  static const String assignAllot = "$baseUrl/admin/recovery-allotment";




  static const String attendanceCreate = "$baseUrl/admin/attandance-create";


  static const String notifications = "$baseUrl/notifications";
}

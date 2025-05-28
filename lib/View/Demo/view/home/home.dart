import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospirent/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cart_provider.dart';
import '../../imports.dart';
import '../../model/product_model.dart';
import '../../widgets/app_name_widget.dart';
import '../../widgets/card/product_card.dart';
import '../../widgets/text/text_builder.dart';
import '../cart/cart.dart';
import '../drawer/drawer_menu.dart';

class Home extends StatefulWidget {
  final int id;
  const Home({Key? key, required this.id}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<ProductModel>>? futureProduct;
  List categories = []; // Declare a list to hold API data
  List services = []; // Declare a list to hold API data
  List banner = []; // Declare a list to hold API data
  bool isLoading = true;

  Future<List<ProductModel>> fetchProducts() async {
    List<ProductModel> products = [];
    var request = http.Request('GET', Uri.parse('${ApiRoutes.getAllProducts}${widget.id}'));

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(responseBody);
      }
      final jsonData = jsonDecode(responseBody);
      final productList = jsonData['products'] as List<dynamic>;
      products = productList.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
      setState(() {});
      return products;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProducts();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }



  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroud,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const AppNameWidget(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.sp),
            bottomRight: Radius.circular(20.sp),
          ),
        ),
        leading: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart(appBar: 'Hone')));
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
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: futureProduct,
          builder: (context, data) {
            if (data.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5 / 4,
                  mainAxisSpacing: 5.sp,
                  crossAxisSpacing: 5.sp,
                ),
                itemCount: data.data!.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  return ProductCard(product: data.data![i]);
                },
              );
            } else if (data.hasError) {
              return Center(
                child: TextBuilder(
                  text: "Failed to load products. Please try again.",
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              );
            }
            return Center(
              child: CupertinoActivityIndicator(
                radius: 30,
                color: AppColors.primary,
              ), // Show progress bar here
            );
          },
        ),
      ),
    );
  }
}
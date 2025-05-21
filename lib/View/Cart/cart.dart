import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your Cart'),
          ElevatedButton(
            onPressed: () {
              if (authProvider.user == null) {
                authProvider.setRedirectRoute('/cart');
                Navigator.pushNamed(context, '/login');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order placed successfully!')),
                );
              }
            },
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

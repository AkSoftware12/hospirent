import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final List<String> products = ['Product 1', 'Product 2', 'Product 3'];

   ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index]),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${products[index]} added to cart')),
              );
            },
          ),
        );
      },
    );
  }
}

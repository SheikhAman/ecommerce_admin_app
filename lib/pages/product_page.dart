import 'package:ecom_day_42/pages/new_product_page.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product_page';
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Product Page'),
      ),
    );
  }
}

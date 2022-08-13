import 'package:ecom_day_42/pages/new_product_page.dart';
import 'package:ecom_day_42/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

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
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.productList.isEmpty
            ? const Center(
                child: const Text('No Item found'),
              )
            : ListView.builder(
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  // index er category model ber korlam
                  final product = provider.productList[index];
                  return ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ProductDetailsPage.routeName,
                      arguments: product.id,
                    ),
                    title: Text(product.name!),
                  );
                }),
      ),
    );
  }
}

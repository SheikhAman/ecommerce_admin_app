import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_day_42/models/product_model.dart';
import 'package:ecom_day_42/providers/product_provider.dart';
import 'package:ecom_day_42/utils/helper_functions.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/product_details';
  const ProductDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // pid means productId
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, _) {
        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: provider.getProductById(pid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final product = ProductModel.fromMap(snapshot.data!.data()!);
                return ListView(
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: 'images/placeholder.jpg',
                      image: product.imageUrl!,
                      fadeInCurve: Curves.bounceInOut,
                      fadeInDuration: Duration(seconds: 3),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Re-Purchase'),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.getPurchaseByProduct(pid);
                            _showPurchaseHistoryBottomSheet(context, provider);
                          },
                          child: const Text('Purchase History'),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(product.name!),
                      trailing: IconButton(
                        onPressed: () {
                          _editProductDetailsDialog(
                              context, provider, product, productName);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    ListTile(
                      title: Text('$currencySymbol${product.salePrice}'),
                      trailing: IconButton(
                        onPressed: () {
                          _editProductDetailsDialog(
                              context, provider, product, productSalePrice);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    ListTile(
                      title: const Text('Product Description'),
                      subtitle: Text(product.description ?? 'Not Available'),
                      trailing: IconButton(
                        onPressed: () {
                          _editProductDetailsDialog(
                              context, provider, product, productDescription);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    SwitchListTile(
                      title: Text('Available'),
                      value: product.available,
                      onChanged: (value) {
                        provider.updateProduct(
                            product.id!, productAvailable, value);
                      },
                    ),
                    SwitchListTile(
                      title: Text('Featured'),
                      value: product.featured,
                      onChanged: (value) {
                        provider.updateProduct(
                            product.id!, productFeatured, value);
                      },
                    )
                  ],
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Failed'),
                );
              }
              // data aste late hole CircularProgressIndicator show korbe
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      }),
    );
  }

  void _showPurchaseHistoryBottomSheet(
      BuildContext context, ProductProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
          itemCount: provider.purchaseListOfSpecificProduct.length,
          itemBuilder: (context, index) {
            final purModel = provider.purchaseListOfSpecificProduct[index];
            return ListTile(
              title: Text(getFormattedDateTime(
                  purModel.dateModel.timestamp.toDate(),
                  pattern: 'dd/MM/yyyy')),
              subtitle: Text('Quantity: ${purModel.quantity}'),
              trailing: Text('$currencySymbol${purModel.purchaseprice}'),
            );
          }),
    );
  }

  void _editProductDetailsDialog(BuildContext context, ProductProvider provider,
      ProductModel product, dynamic field) {
    final productController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Product Info'),
        content: TextField(
          controller: productController,
          decoration: InputDecoration(
              hintText: 'Edit product information',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CLOSE'),
          ),
          TextButton(
            onPressed: () {
              provider.updateProduct(
                  product.id!, field, productController.text);
              Navigator.pop(context);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }
}

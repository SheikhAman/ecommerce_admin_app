import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order_page';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
    );
  }
}

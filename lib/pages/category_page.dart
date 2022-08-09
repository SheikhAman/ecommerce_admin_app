import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category_name';
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page'),
      ),
    );
  }
}

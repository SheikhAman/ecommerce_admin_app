import 'package:ecom_day_42/models/category_model.dart';
import 'package:ecom_day_42/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category_name';
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.categoryList.isEmpty
            ? const Center(
                child: const Text('No Item found'),
              )
            : ListView.builder(
                itemCount: provider.categoryList.length,
                itemBuilder: (context, index) {
                  // index er category model ber korlam
                  final category = provider.categoryList[index];
                  return ListTile(
                    title:
                        Text('${category.catName} (${category.productCount})'),
                  );
                }),
      ),
    );
  }

// Ai method comment korlam karon aikhane DraggableScrollableSheet use kora hoi nai
  // void _showAddCategoryBottomSheet(BuildContext context) {
  //   final nameController = TextEditingController();
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => DraggableScrollableSheet(
  //       initialChildSize: 0.6,
  //       expand: false,
  //       builder: (context, scrollController) => Card(
  //         elevation: 5,
  //         child: ListView(
  //           controller: scrollController,
  //           padding: EdgeInsets.all(16),
  //           children: [
  //             TextField(
  //               controller: nameController,
  //               decoration: InputDecoration(
  //                 hintText: 'Enter New Category',
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(20)),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 context
  //                     .read<ProductProvider>()
  //                     .addCategories(
  //                         CategoryModel(catName: nameController.text))
  //                     .then((value) {
  //                   nameController.clear();
  //                 });
  //               },
  //               child: Text('Add'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('CLOSE'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ADD CATEGORY'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
              hintText: 'Enter new category',
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
              context
                  .read<ProductProvider>()
                  .addCategories(CategoryModel(catName: nameController.text))
                  .then((value) {
                nameController.clear();
              });
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}

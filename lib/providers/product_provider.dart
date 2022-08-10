import 'package:ecom_day_42/db/db_helper.dart';
import 'package:ecom_day_42/models/category_model.dart';
import 'package:ecom_day_42/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];

// addCategory method call korum  category page theke
  Future<void> addCategories(CategoryModel categoryModel) =>
      DBHelper.addNewCategory(categoryModel);

// ai method categories list page ar product add korar somoy lagbe, example droupdown e lagbe
  getAllCategories() {
    DBHelper.getAllCategory().listen((snapshot) {
      // snapshot hoche akhane QuerySnapshot<Map<String, dynamic>>
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}

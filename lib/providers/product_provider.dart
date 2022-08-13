import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_day_42/db/db_helper.dart';
import 'package:ecom_day_42/models/category_model.dart';
import 'package:ecom_day_42/models/product_model.dart';
import 'package:ecom_day_42/models/purchase_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  // akta  nirdisto product er purchase List
  List<PurchaseModel> purchaseListOfSpecificProduct = [];

// addCategory method call korum  category page theke
  Future<void> addCategories(CategoryModel categoryModel) =>
      DBHelper.addNewCategory(categoryModel);

  Future<void> addNewProduct(ProductModel productModel,
      PurchaseModel purchaseModel, CategoryModel categoryModel) {
    final count = categoryModel.productCount + purchaseModel.quantity;

    return DBHelper.addProduct(
        productModel, purchaseModel, categoryModel.catId!, count);
  }

// ai method categories list page ar product add korar somoy lagbe, example droupdown e lagbe
  // categoryList a add hobe
  getAllCategories() {
    DBHelper.getAllCategory().listen((snapshot) {
      // snapshot hoche akhane QuerySnapshot<Map<String, dynamic>>
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

// product add korar  jonno  akta method lekhbo

  getAllProducts() {
    DBHelper.getAllProducts().listen((snapshot) {
      productList = List.generate(snapshot.docs.length,
          (index) => ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  //  akta  nirdisto product er purchase List
  getPurchaseByProduct(String pid) {
    DBHelper.getPurchaseByProductId(pid).listen((snapshot) {
      purchaseListOfSpecificProduct = List.generate(
        snapshot.docs.length,
        (index) => PurchaseModel.fromMap(snapshot.docs[index].data()),
      );
      print(purchaseListOfSpecificProduct.length);
      notifyListeners();
    });
  }

// category model er name er shate match hole sei  category model er object return korbe
  CategoryModel getCategoryModelByCatName(String name) {
    final catModel = categoryList.firstWhere((model) => model.catName == name);
    return catModel;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      DBHelper.getProductById(id);

  // common method for updating Product details info
  Future<void> updateProduct(String id, String field, dynamic value) {
    // field bolte amra key o dhorte pari
    return DBHelper.updateProduct(id, {field: value});
  }

  Future<String> updateImage(XFile xFile) async {
    // image name ki hobe ta string e convert kori
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();

    // FirebaseStorage.instance.ref() return  kore root reference
    // tarpor child reference nibo aikhane pictures folder er under e image name er akta file save hobe
    final photoRef =
        FirebaseStorage.instance.ref().child('pictures/$imageName');

    // file upload korar jonnoo putFile method bebohar korbo
    // seta File parameter nei tarvitore xFile.path diye dibo
    // putFile method return kore UploadTask

    final uploadTask = photoRef.putFile(File(xFile.path));

    // uploadTask  complete hoyeche check korar jonno method  call korlam
    // whenComplete return kor snapshot
    final snapshot = await uploadTask.whenComplete(() =>
        null); // complete  howar por kono kichu chaile show o korte partam

    // snapshot.ref photoRef ke reference korche
    return snapshot.ref.getDownloadURL();
  }
}

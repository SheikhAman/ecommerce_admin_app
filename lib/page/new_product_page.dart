import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/product_model.dart';
import '/models/purchase_model.dart';
import '/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/date_model.dart';
import '../utils/helper_functions.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({Key? key}) : super(key: key);
  static const String routeName = '/new_product_page';

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String? _category;

  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productSalePriceController = TextEditingController();
  final productPurchasePriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  DateTime? _productPurchaseDate;
  bool _isUploading = false;
  String? _imageUrl;
  ImageSource _imageSource = ImageSource.camera;

  final form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productSalePriceController.dispose();
    productPurchasePriceController.dispose();
    productQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _isUploading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : TextButton(
                  onPressed: _saveProduct,
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
        ],
        title: const Text('Add New Product'),
      ),
      body: Form(
        key: form_key,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: productNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.shopping_bag_outlined),
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'This field must not be empty!';
              //   }
              //   if (value.length > 20) {
              //     return 'Name must be in 20 characters';
              //   } else {
              //     return null;
              //   }
              // },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: productPurchasePriceController,
                    decoration: const InputDecoration(
                      labelText: 'Purchase price',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: productSalePriceController,
                    decoration: const InputDecoration(
                      labelText: 'Sale price',
                      prefixIcon: Icon(Icons.price_change),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: productQuantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      prefixIcon: Icon(Icons.production_quantity_limits),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    child: DropdownButtonHideUnderline(
                      child: Consumer<ProductProvider>(
                        builder: (context, provider, _) =>
                            DropdownButtonFormField<String>(
                                hint: const Text('Select'),
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                value: _category,
                                items: provider.categoryList
                                    .map((model) => DropdownMenuItem<String>(
                                          value: model.name,
                                          child: Text(model.name!),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a category';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    _category = val;
                                  });
                                }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: productDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Product Description',
                prefixIcon: Icon(Icons.description),
              ),
              minLines: 2,
              maxLines: 5,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'This field must not be empty!';
              //   } else {
              //     return null;
              //   }
              // },
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _selectDate,
                    child: const Text('Select purchase Date'),
                  ),
                  Chip(
                    label: Text(_productPurchaseDate == null
                        ? 'No Date chosen'
                        : getFormattedDateTime(
                            _productPurchaseDate!, 'dd/MM/yyyy')),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: _imageUrl == null
                        ? const Icon(
                            Icons.photo,
                            size: 110,
                          )
                        : Image.network(
                            _imageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _imageSource = ImageSource.camera;
                        _getImage();
                      },
                      label: const Text('Camera'),
                      icon: const Icon(Icons.camera),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _imageSource = ImageSource.gallery;
                        _getImage();
                      },
                      label: const Text('Gallery'),
                      icon: const Icon(Icons.photo),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2030));

    if (selectedDate != null) {
      setState(() {
        _productPurchaseDate = selectedDate;
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      setState(() {
        _isUploading = true;
      });
      try {
        final url =
            await context.read<ProductProvider>().updateImage(selectedImage);
        setState(() {
          _imageUrl = url;
          _isUploading = false;
        });
      } catch (e) {}
    }
  }

  void _saveProduct() {
    if (_productPurchaseDate == null) {
      showMsg(context, 'Please select a purchase date');
      return;
    }
    if (_imageUrl == null) {
      showMsg(context, 'Please select an image');
      return;
    }

    if (form_key.currentState!.validate()) {
      EasyLoading.showProgress(0.3, status: 'Please wait...');
      final productModel = ProductModel(
          name: productNameController.text,
          description: productDescriptionController.text,
          salesPrice: num.parse(productSalePriceController.text),
          category: _category,
          imageUrl: _imageUrl,
          stock: num.parse(productQuantityController.text));
      final purchaseModel = PurchaseModel(
        dateModel: DateModel(
          timestamp: Timestamp.fromDate(_productPurchaseDate!),
          day: _productPurchaseDate!.day,
          month: _productPurchaseDate!.month,
          year: _productPurchaseDate!.year,
        ),
        price: num.parse(productPurchasePriceController.text),
        quantity: num.parse(productQuantityController.text),
      );
      final catModel =
          context.read<ProductProvider>().getCategoryModelByCatName(_category!);
      context
          .read<ProductProvider>()
          .addNewProduct(productModel, purchaseModel, catModel)
          .then((_) {
        EasyLoading.dismiss(animation: true);
        _resetFields();
      }).catchError((error) {
        showMsg(context, 'Could not save');
        throw error;
      });
    }
  }

  void _resetFields() {
    setState(() {
      productNameController.clear();
      productDescriptionController.clear();
      productPurchasePriceController.clear();
      productSalePriceController.clear();
      productQuantityController.clear();
      _imageUrl = null;
      _category = null;
      _productPurchaseDate = null;
    });
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_day_42/models/date_model.dart';
import 'package:ecom_day_42/models/product_model.dart';
import 'package:ecom_day_42/models/purchase_model.dart';
import 'package:ecom_day_42/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/new_product_page';
  const NewProductPage({Key? key}) : super(key: key);

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productSalePriceController = TextEditingController();
  final productPurchasePriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  ImageSource source = ImageSource.camera;

  String? _imageUrl;

  String? purchaseDate;

  String? _category;

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productSalePriceController.dispose();
    productPurchasePriceController.dispose();
    productQuantityController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product Page'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Center(
                      child: _imageUrl == null
                          ? Image.asset(
                              'images/profile.png',
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_imageUrl!),
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                        bottom: -5,
                        right: size.width / 2 - 80,
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        elevation: 8,
                                        actions: [
                                          ListTile(
                                            onTap: () {
                                              source = ImageSource.camera;
                                              getImage();
                                              Navigator.of(context).pop();
                                            },
                                            title: Icon(
                                              Icons.camera_alt_outlined,
                                            ),
                                            subtitle: Text('Image from Camera'),
                                          ),
                                          Divider(),
                                          ListTile(
                                            onTap: () {
                                              source = ImageSource.gallery;
                                              getImage();
                                              Navigator.of(context).pop();
                                            },
                                            title: Icon(
                                              Icons.photo_library_outlined,
                                            ),
                                            subtitle:
                                                Text('Image from Gallery'),
                                          ),
                                        ],
                                      ));
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.black54,
                              size: 35,
                            )))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // todo Product Name Textfield section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: productNameController,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe6e6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(Icons.card_giftcard),
                    hintText: 'Enter the product name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              // todo  Product Sale Price Textfield section

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: productSalePriceController,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe6e6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    hintText: 'Enter the product sale price',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              // todo Product Purchase Price Textfield section

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: productPurchasePriceController,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe6e6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(Icons.monetization_on),
                    hintText: 'Enter the product purchase price',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
// todo Product Quantity Textfield section

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: productQuantityController,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe6e6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(Icons.clean_hands_outlined),
                    hintText: 'Enter the product quantity',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),

// todo Product  Description  Textfield section

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: productDescriptionController,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe6e6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Enter the product description',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              // todo Purchase Date Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Color(0xffe6e6e6),
                  leading: Text(
                    'Purchase Date:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  title: Center(
                    child: Text(
                      purchaseDate ?? 'No date chosen',
                      style: TextStyle(
                          color: purchaseDate == null
                              ? Colors.grey
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: showPurchaseDatePicker,
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.red,
                      )),
                ),
              ),
              // todo Select Category using DropdownButton
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Color(0xffe6e6e6),
                  leading: Text(
                    'Select category:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  title: Consumer<ProductProvider>(
                    builder: (context, provider, _) =>
                        DropdownButtonFormField<String>(
                      hint: const Text('Select'),
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor: Colors.white,
                      isExpanded: false,
                      // user je value ta sellect korbe setai hoche _category
                      value: _category,
                      icon: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.red,
                        ),
                      ),

                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500),
                      items: provider.categoryList.map((model) {
                        return DropdownMenuItem<String>(
                          value: model.catName,
                          child: Center(child: Text(model.catName!)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _category = newValue;
                        });
                      },

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        // user kono kichu select na korle null return korbe
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: saveProduct,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Save Product',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      try {
        final url =
            await context.read<ProductProvider>().updateImage(selectedImage);
        setState(() {
          _imageUrl = url;
        });
      } catch (e) {}
    }
  }

  void showPurchaseDatePicker() async {
    DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    print('selectDate' + selectDate.toString());
    if (selectDate != null) {
      setState(() {
        purchaseDate = DateFormat("dd/MM/yy").format(selectDate);
      });
    }
  }

// save korle 2ta class er object create hobe
  void saveProduct() {
    if (formKey.currentState!.validate()) {
      final productModel = ProductModel(
        name: productNameController.text,
        description: productDescriptionController.text,
        salePrice: num.parse(productSalePriceController.text),
        category: _category,
        imageUrl: _imageUrl,
        // id porre asbe
      );

      final purchaseModel = PurchaseModel(
          dateModel: DateModel(
            timestamp: Timestamp.now(),
            day: DateTime.now().day,
            month: DateTime.now().month,
            year: DateTime.now().year,
          ),
          purchaseprice: num.parse(productPurchasePriceController.text),
          quantity: num.parse(productQuantityController.text));

// _category hoche dropdownValue
      final catModel =
          context.read<ProductProvider>().getCategoryModelByCatName(_category!);

// catModel hoche  akahte category er model
      context
          .read<ProductProvider>()
          .addNewProduct(productModel, purchaseModel, catModel)
          .then((_) {
// then mane successfull vabe insert hoise
// tarpor sob gulo field reset kore dibo
        _resetField();
      }).catchError((error) {
        // batch operation successfull na hole error show korbe terminal e
      });
    }
  }

  void _resetField() {
    setState(() {
      productNameController.clear();
      productDescriptionController.clear();
      productSalePriceController.clear();
      productPurchasePriceController.clear();
      productQuantityController.clear();

      _imageUrl = null;
      // category  hoche droupdownvalue category er
      _category = null;
    });
  }
}

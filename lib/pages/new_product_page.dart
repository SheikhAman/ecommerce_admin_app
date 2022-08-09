import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  String? imagePath;

  String? purchaseDate;

  String bookCategory = 'OTHERS';

  var categoryItems = ['LAPTOP', 'WATCH', 'DRESS', 'MOBILE', 'BIKE', 'OTHERS'];

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
                      child: imagePath == null
                          ? Image.asset(
                              'images/profile.png',
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath!),
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
                    hintText: 'Enter the product price',
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
                  trailing: DropdownButton(
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor: Colors.white,
                      underline: Text(''),
                      value: bookCategory,
                      icon: Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.red,
                        ),
                      ),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500),
                      items: categoryItems.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Center(
                            child: Text(item),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          bookCategory = newValue!;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: addProduct,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Product',
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
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }

  void showPurchaseDatePicker() async {
    DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (selectDate != null) {
      setState(() {
        purchaseDate = DateFormat("dd/MM/yy").format(selectDate);
      });
    }
  }

  void addProduct() {}
}

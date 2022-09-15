import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../models/order_constants_model.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ProductProvider productProvider;
  late OrderProvider orderProvider;
  double deliveryChargeSliderValue = 0;
  double discountSliderValue = 0;
  double vatSliderValue = 0;
  bool needUpdate = false;
  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getOrderConstants().then((_) {
      setState(() {
        deliveryChargeSliderValue =
            orderProvider.orderConstantsModel.deliveryCharge.toDouble();
        discountSliderValue =
            orderProvider.orderConstantsModel.discount.toDouble();
        vatSliderValue = orderProvider.orderConstantsModel.vat.toDouble();
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Delivery Charge'),
                    trailing: Text(
                        '$currencySymbol${deliveryChargeSliderValue.round()}'),
                  ),
                  Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      min: 0,
                      max: 500,
                      divisions: 50,
                      label: deliveryChargeSliderValue.toStringAsFixed(0),
                      value: deliveryChargeSliderValue.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          deliveryChargeSliderValue = value;
                          _checkUpdate();
                        });
                      }),
                  ListTile(
                    title: const Text('Discount'),
                    trailing: Text('${discountSliderValue.round()}%'),
                  ),
                  Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: discountSliderValue.toStringAsFixed(0),
                      value: discountSliderValue.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          discountSliderValue = value;
                          _checkUpdate();
                        });
                      }),
                  ListTile(
                    title: const Text('VAT'),
                    trailing: Text('${vatSliderValue.round()}%'),
                  ),
                  Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      min: 0,
                      max: 150,
                      divisions: 150,
                      label: vatSliderValue.toStringAsFixed(0),
                      value: vatSliderValue.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          vatSliderValue = value;
                          _checkUpdate();
                        });
                      }),
                  ElevatedButton(
                    onPressed: needUpdate
                        ? () {
                            EasyLoading.show(status: 'Please wait');
                            final model = OrderConstantsModel(
                              deliveryCharge: deliveryChargeSliderValue,
                              discount: discountSliderValue,
                              vat: vatSliderValue,
                            );
                            orderProvider.addOrderConstants(model).then((_) {
                              EasyLoading.dismiss(animation: true);
                              showMsg(context, 'Updated');
                              setState(() {
                                needUpdate = false;
                              });
                            });
                          }
                        : null,
                    child: const Text('UPDATE'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkUpdate() {
    needUpdate = deliveryChargeSliderValue !=
            orderProvider.orderConstantsModel.deliveryCharge.toDouble() ||
        discountSliderValue !=
            orderProvider.orderConstantsModel.discount.toDouble() ||
        vatSliderValue != orderProvider.orderConstantsModel.vat.toDouble();
  }
}

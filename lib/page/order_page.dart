import 'package:cloud_firestore/cloud_firestore.dart';
import '/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import 'order_list_page.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${provider.getTotalOrderByDate(DateTime.now())}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '$currencySymbol${provider.getTotalSaleByDate(DateTime.now())}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, OrderListPage.routeName,
                          arguments: OrderFilter.TODAY),
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Yesterday',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${provider.getTotalOrderByDate(DateTime.now().subtract(const Duration(days: 1)))}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '$currencySymbol${provider.getTotalSaleByDate(DateTime.now().subtract(const Duration(days: 1)))}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, OrderListPage.routeName,
                          arguments: OrderFilter.YESTERDAY),
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Last 7 days',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${provider.getTotalOrderByDateRange(DateTime.now().subtract(const Duration(days: 7)))}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '$currencySymbol${provider.getTotalSaleByDateRange(DateTime.now().subtract(const Duration(days: 7)))}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, OrderListPage.routeName,
                          arguments: OrderFilter.SEVEN_DAYS),
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'This Month',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${provider.getTotalOrderByDateRange(DateTime(DateTime.now().year, DateTime.now().month - 1))}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '$currencySymbol${provider.getTotalSaleByDateRange(DateTime(DateTime.now().year, DateTime.now().month - 1))}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, OrderListPage.routeName,
                          arguments: OrderFilter.THIS_MONTH),
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'All Time',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Order'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${provider.orderList.length}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Total Sale'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '$currencySymbol${provider.getAllTimeTotalSale()}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, OrderListPage.routeName,
                          arguments: OrderFilter.ALL_TIME),
                      child: const Text('View All'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ecom_day_42/page/order_details_page.dart';
import '/providers/order_provider.dart';
import '/utils/constants.dart';
import '/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/order_list';

  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderFilter =
        ModalRoute.of(context)!.settings.arguments as OrderFilter;
    final orderList = Provider.of<OrderProvider>(context, listen: false)
        .getFilteredList(orderFilter);
    orderList.sort((orderM1, orderM2) =>
        orderM2.orderDate.timestamp.compareTo(orderM1.orderDate.timestamp));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order List'),
        ),
        body: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            final order = orderList[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(
                  context, OrderDetailsPage.routeName,
                  arguments: order),
              title: Text(getFormattedDateTime(
                  order.orderDate.timestamp.toDate(), 'dd/MM/yyyy hh:mm:ss a')),
              trailing: Text('$currencySymbol${order.grandTotal}'),
            );
          },
        ));
  }
}

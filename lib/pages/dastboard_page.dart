import 'package:ecom_day_42/models/dashboard_item.dart';
import 'package:ecom_day_42/widgets/dashboard_item_view.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dash_board_page';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),

      ),
body: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    ),
    itemCount: dashboardItems.length,
    itemBuilder: (context,index) => DashboardItemView(item: dashboardItems[index], onPressed: (value){})),
    );
  }
}

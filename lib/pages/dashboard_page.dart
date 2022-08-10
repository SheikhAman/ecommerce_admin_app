import 'package:ecom_day_42/auth/auth_service.dart';
import 'package:ecom_day_42/models/dashboard_item.dart';
import 'package:ecom_day_42/pages/category_page.dart';
import 'package:ecom_day_42/pages/launcher_page.dart';
import 'package:ecom_day_42/pages/new_product_page.dart';
import 'package:ecom_day_42/providers/product_provider.dart';
import 'package:ecom_day_42/widgets/dashboard_item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_page.dart';
import 'product_page.dart';
import 'report_page.dart';
import 'settings_page.dart';
import 'user_page.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dash_board_page';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout();
              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewProductPage.routeName);
        },
        child: Icon(Icons.add),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) => DashboardItemView(
              item: dashboardItems[index],
              onPressed: (value) {
                String route = navigate(value);
                Navigator.pushNamed(context, route);
              })),
    );
  }

  String navigate(String value) {
    String route = '';
    switch (value) {
      case DashboardItem.product:
        route = ProductPage.routeName;
        break;
      case DashboardItem.category:
        route = CategoryPage.routeName;
        break;
      case DashboardItem.order:
        route = OrderPage.routeName;
        break;
      case DashboardItem.user:
        route = UserPage.routeName;
        break;
      case DashboardItem.settings:
        route = SettingsPage.routeName;
        break;
      case DashboardItem.report:
        route = ReportPage.routeName;
        break;
    }
    return route;
  }
}

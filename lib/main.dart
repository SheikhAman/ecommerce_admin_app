import 'package:ecom_day_42/pages/dashboard_page.dart';
import 'package:ecom_day_42/pages/launcher_page.dart';
import 'package:ecom_day_42/pages/login_page.dart';
import 'package:ecom_day_42/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'pages/category_page.dart';
import 'pages/new_product_page.dart';
import 'pages/order_page.dart';
import 'pages/product_page.dart';
import 'pages/report_page.dart';
import 'pages/settings_page.dart';
import 'pages/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => LauncherPage(),
        LoginPage.routeName: (context) => LoginPage(),
        DashboardPage.routeName: (context) => DashboardPage(),
        CategoryPage.routeName: (context) => CategoryPage(),
        NewProductPage.routeName: (context) => NewProductPage(),
        OrderPage.routeName: (context) => OrderPage(),
        ProductPage.routeName: (context) => ProductPage(),
        ReportPage.routeName: (context) => ReportPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
        UserPage.routeName: (context) => UserPage(),
      },
    );
  }
}

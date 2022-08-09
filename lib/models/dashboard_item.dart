import 'package:flutter/material.dart';

class DashboardItem {
  // fields
  IconData icon;
  String title;

// constructor
  DashboardItem({required this.icon, required this.title});

// constants
  static const String product = 'Product';
  static const String category = 'Category';
  static const String order = 'Orders';
  static const String user = 'Users';
  static const String settings = 'Settings';
  static const String report = 'Report';
}

// object list
final List<DashboardItem> dashboardItems = [
  DashboardItem(icon: Icons.card_giftcard, title: DashboardItem.product),
  DashboardItem(icon: Icons.category, title: DashboardItem.category),
  DashboardItem(icon: Icons.monetization_on, title: DashboardItem.order),
  DashboardItem(icon: Icons.person, title: DashboardItem.user),
  DashboardItem(icon: Icons.settings, title: DashboardItem.settings),
  DashboardItem(icon: Icons.area_chart, title: DashboardItem.report),
];

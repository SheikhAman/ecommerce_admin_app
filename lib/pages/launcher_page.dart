import 'package:ecom_day_42/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/auth_service.dart';
import 'login_page.dart';

class LauncherPage extends StatefulWidget {
  static final String routeName = '/launcher_page';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    // auth korar somoy Future.delayed method call korte hobe init state e nahole error dibe
    Future.delayed(Duration.zero, () {
      if (AuthService.user == null) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

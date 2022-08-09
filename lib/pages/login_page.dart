import 'package:ecom_day_42/pages/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import 'launcher_page.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;
  final formKey = GlobalKey<FormState>();
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                Text('Welcome User'),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: isObscure,
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: authenticate, child: Text('Login')),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  errMsg,
                  style: TextStyle(color: Theme.of(context).errorColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  authenticate() async {
    if (formKey.currentState!.validate()) {
      try {
        final status = await AuthService.login(
            emailController.text, passwordController.text);
        if (status) {
          // status true tai launcher page amake dashbaord e niye jabe
          Navigator.pushReplacementNamed(context, LauncherPage.routeName);
        } else {
          AuthService.logout();
          setState(() {
            errMsg = 'You are not an Admin';
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          errMsg = e.message!;
        });
      }
    }
  }
}

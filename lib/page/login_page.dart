import '/auth/auth_service.dart';
import '/page/launcher_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  String errMsg = '';

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isObscureText,
                controller: passController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () => setState(() {
                      isObscureText = !isObscureText;
                    }),
                  ),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  authenticate();
                },
                child: const Text('LOGIN'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot Password?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Click Here'),
                  )
                ],
              ),
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
    );
  }

  authenticate() async {
    if (formKey.currentState!.validate()) {
      try {
        final status =
            await AuthService.login(emailController.text, passController.text);
        if (status) {
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

import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.cyan,
          title: const Center(child: Text("Login", textAlign: TextAlign.center)),
        ),
      ),
      body: const LoginForm(),
    );
  }
}
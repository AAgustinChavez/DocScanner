import 'package:flutter/material.dart';
import 'package:doc_scanner/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocScanner',
      home: LoginPage(),
    );
  }
}
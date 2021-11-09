import 'package:doc_scanner/auth/google_sign_in.dart';
import 'package:doc_scanner/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Doc Scanner';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<GoogleSignInProvider>(create: (context) => GoogleSignInProvider()),
          
        ],
        child: const LoginPage(),
      ),
    );
    
  }
}
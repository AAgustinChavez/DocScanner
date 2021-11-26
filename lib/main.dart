import 'package:doc_scanner/create_file_img.dart';
import 'package:doc_scanner/login/login_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/bloc/auth_bloc.dart';

void main() async {
  // inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // inicializar auth bloc provider

  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(VerifyAuthEvent()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // bloc builder con estados de auth bloc
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AlreadyAuthState) {
          return const CreateFileIMG();
        } else if (state is UnAuthState) {
          return const LoginTest();
        } 
        return const LoginTest();
      },
    ));
  }
}